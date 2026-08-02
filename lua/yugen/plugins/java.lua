local java_markers = {
  "gradlew",
  "mvnw",
  ".git",
  "pom.xml",
  "build.gradle",
  "build.gradle.kts",
  "settings.gradle",
  "settings.gradle.kts",
}

local function mason_path(path)
  return vim.fn.stdpath("data") .. "/mason/" .. path
end

local function jdtls_executable()
  local mason_jdtls = mason_path("bin/jdtls")
  if vim.fn.executable(mason_jdtls) == 1 then
    return mason_jdtls
  end
  return vim.fn.exepath("jdtls")
end

local function java_bundles()
  local packages = mason_path("packages")
  local bundles = vim.fn.glob(
    packages .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
    true,
    true
  )
  local excluded = {
    ["com.microsoft.java.test.runner-jar-with-dependencies.jar"] = true,
    ["jacocoagent.jar"] = true,
  }

  for _, jar in ipairs(vim.fn.glob(packages .. "/java-test/extension/server/*.jar", true, true)) do
    if not excluded[vim.fn.fnamemodify(jar, ":t")] then
      table.insert(bundles, jar)
    end
  end

  return bundles
end

local function project_root(bufnr)
  local root = vim.fs.root(bufnr, java_markers)
  if root then
    return root
  end

  local filename = vim.api.nvim_buf_get_name(bufnr)
  if filename ~= "" then
    return vim.fs.dirname(filename)
  end

  return vim.fn.getcwd()
end

local function run_java_file(bufnr)
  local filename = vim.api.nvim_buf_get_name(bufnr)
  if filename == "" then
    vim.notify("Save the Java file before running it", vim.log.levels.WARN)
    return
  end

  if vim.bo[bufnr].modified then
    vim.api.nvim_buf_call(bufnr, function()
      vim.cmd.write()
    end)
  end

  local java = vim.fn.exepath("java")
  if java == "" then
    vim.notify("Java was not found in PATH", vim.log.levels.ERROR)
    return
  end

  vim.cmd("botright 12split")
  vim.cmd("terminal " .. vim.fn.shellescape(java) .. " " .. vim.fn.shellescape(filename))
  vim.cmd.startinsert()
end

local function format_java_file(bufnr)
  local filename = vim.api.nvim_buf_get_name(bufnr)
  if filename == "" then
    vim.notify("Save the Java file before formatting it", vim.log.levels.WARN)
    return
  end

  if vim.bo[bufnr].modified then
    vim.api.nvim_buf_call(bufnr, function()
      vim.cmd.write()
    end)
  end

  local formatter = mason_path("bin/google-java-format")
  if vim.fn.executable(formatter) ~= 1 then
    formatter = vim.fn.exepath("google-java-format")
  end
  if formatter == "" then
    vim.notify("google-java-format is missing. Run :YugenInstallJava", vim.log.levels.ERROR)
    return
  end

  local result = vim.system({ formatter, "--replace", filename }, { text = true }):wait()
  if result.code ~= 0 then
    vim.notify(result.stderr or "google-java-format failed", vim.log.levels.ERROR)
    return
  end

  vim.api.nvim_buf_call(bufnr, function()
    vim.cmd.checktime()
  end)
  vim.notify("Java file formatted")
end

local function setup_java_buffer(bufnr)
  vim.api.nvim_buf_create_user_command(bufnr, "JavaRun", function()
    run_java_file(bufnr)
  end, {
    desc = "Run the current Java source file",
    force = true,
  })

  vim.api.nvim_buf_create_user_command(bufnr, "JavaFormat", function()
    format_java_file(bufnr)
  end, {
    desc = "Format the current file with google-java-format",
    force = true,
  })

  vim.keymap.set("n", "<leader>jr", function()
    run_java_file(bufnr)
  end, { buffer = bufnr, desc = "Java: run current file" })
  vim.keymap.set("n", "<leader>jf", function()
    format_java_file(bufnr)
  end, { buffer = bufnr, desc = "Java: format with google-java-format" })
end

local function start_jdtls(bufnr)
  setup_java_buffer(bufnr)

  local cmd = jdtls_executable()
  if cmd == "" then
    vim.notify("jdtls is missing. Run :YugenInstallJava", vim.log.levels.WARN)
    return
  end

  local jdtls = require("jdtls")
  local root_dir = project_root(bufnr)
  local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
  local workspace_dir = vim.fn.stdpath("data")
    .. "/jdtls-workspaces/"
    .. project_name
    .. "-"
    .. vim.fn.sha256(root_dir):sub(1, 12)

  local config = {
    name = "jdtls",
    cmd = { cmd, "-data", workspace_dir },
    root_dir = root_dir,
    capabilities = require("blink.cmp").get_lsp_capabilities(),
    settings = {
      java = {
        eclipse = { downloadSources = true },
        maven = { downloadSources = true },
        configuration = { updateBuildConfiguration = "interactive" },
        signatureHelp = { enabled = true },
        implementationsCodeLens = { enabled = true },
        referencesCodeLens = { enabled = true },
        references = { includeDecompiledSources = true },
        sources = {
          organizeImports = {
            starThreshold = 9999,
            staticStarThreshold = 9999,
          },
        },
      },
    },
    init_options = {
      bundles = java_bundles(),
    },
    on_attach = function(_, attached_bufnr)
      local function map(lhs, rhs, desc, mode)
        vim.keymap.set(mode or "n", lhs, rhs, { buffer = attached_bufnr, desc = desc })
      end

      map("<leader>jo", jdtls.organize_imports, "Java: organize imports")
      map("<leader>jd", "<cmd>DapNew<cr>", "Java: run/debug main class")
      map("<leader>jt", jdtls.test_nearest_method, "Java: test nearest method")
      map("<leader>jT", jdtls.test_class, "Java: test class")
      map("<leader>jv", jdtls.extract_variable, "Java: extract variable")
      map("<leader>jv", function()
        jdtls.extract_variable(true)
      end, "Java: extract variable", "v")
      map("<leader>jm", function()
        jdtls.extract_method(true)
      end, "Java: extract method", "v")
      map("<leader>jc", "<cmd>JdtCompile full<cr>", "Java: compile project")
      map("<leader>ju", "<cmd>JdtUpdateConfig<cr>", "Java: update project config")
    end,
  }

  vim.api.nvim_buf_call(bufnr, function()
    jdtls.start_or_attach(config)
  end)
end

return {
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    dependencies = {
      "mfussenegger/nvim-dap",
      "saghen/blink.cmp",
    },
    config = function()
      local group = vim.api.nvim_create_augroup("YugenJava", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = "java",
        callback = function(event)
          start_jdtls(event.buf)
        end,
      })

      local bufnr = vim.api.nvim_get_current_buf()
      if vim.bo[bufnr].filetype == "java" then
        start_jdtls(bufnr)
      end
    end,
  },
}
