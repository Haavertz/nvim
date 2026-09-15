local M = {
  "mason-org/mason.nvim",
  cmd = {
    "Mason",
    "MasonInstall",
    "MasonUninstall",
    "MasonUpdate",
    "MasonLog",
    "MasonInstallLSPs",
    "JavaInstall",
  },
  opts = {
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  },
}

M.tools = {
  { kind = "lsp", lsp = "lua_ls", mason = "lua-language-server" },
  { kind = "lsp", lsp = "eslint", mason = "eslint-lsp" },
  { kind = "lsp", lsp = "pyright", mason = "pyright" },
  { kind = "lsp", lsp = "emmet_language_server", mason = "emmet-language-server" },
  { kind = "lsp", lsp = "html", mason = "html-lsp" },
  { kind = "lsp", lsp = "cssls", mason = "css-lsp" },
  { kind = "lsp", lsp = "ts_ls", mason = "typescript-language-server" },
  { kind = "lsp", lsp = "gopls", mason = "gopls"},
  { kind = "lsp", lsp = "templ", mason = "templ"},
  { kind = "lsp", lsp = "qmlls", mason = "qmlls" },
  { kind = "java", mason = "jdtls" },
  { kind = "java", mason = "java-debug-adapter" },
  { kind = "java", mason = "java-test" },
  { kind = "java", mason = "google-java-format" },
}

local function package_names(kind)
  local names = {}
  local seen = {}

  for _, tool in ipairs(M.tools) do
    if tool.mason and (not kind or tool.kind == kind) and not seen[tool.mason] then
      seen[tool.mason] = true
      table.insert(names, tool.mason)
    end
  end

  return names
end

function M.lsp_names()
  local names = {}

  for _, tool in ipairs(M.tools) do
    if tool.kind == "lsp" and tool.lsp then
      table.insert(names, tool.lsp)
    end
  end

  return names
end

function M.prepend_mason_bin()
  local mason_bin = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin")
  local path = vim.env.PATH or ""
  local entries = vim.split(path, ":", { plain = true })

  if vim.fn.isdirectory(mason_bin) == 1 and not vim.tbl_contains(entries, mason_bin) then
    vim.env.PATH = mason_bin .. ":" .. path
  end
end

local function install_missing(package_list, command_name)
  local registry = require("mason-registry")

  registry.refresh(function()
    local packages = {}
    local unknown = {}

    for _, package_name in ipairs(package_list) do
      local ok, package = pcall(registry.get_package, package_name)
      if not ok then
        table.insert(unknown, package_name)
      elseif not package:is_installed() then
        table.insert(packages, package)
      end
    end

    if #unknown > 0 then
      vim.notify(
        ("%s: unknown Mason package(s): %s"):format(command_name, table.concat(unknown, ", ")),
        vim.log.levels.WARN
      )
    end

    if #packages == 0 then
      vim.notify(command_name .. ": all known tools are already installed", vim.log.levels.INFO)
      return
    end

    for _, package in ipairs(packages) do
      package:install()
    end

    vim.notify(("%s: installing %d tool(s)"):format(command_name, #packages), vim.log.levels.INFO)
  end)
end

local function create_install_command(name, packages, description)
  pcall(vim.api.nvim_del_user_command, name)
  vim.api.nvim_create_user_command(name, function()
    install_missing(packages, name)
  end, { desc = description })
end

function M.setup_install_commands()
  create_install_command(
    "MasonInstallLSPs",
    package_names(),
    "Install missing LSP and Java tools from the Yugen registry"
  )
  create_install_command(
    "JavaInstall",
    package_names("java"),
    "Install missing Java LSP, debugger, tests, and formatter"
  )
end

M.config = function(_, opts)
  require("mason").setup(opts)
  M.setup_install_commands()
end

return M
