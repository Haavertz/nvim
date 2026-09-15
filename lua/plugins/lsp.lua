local lsp_manager = require("plugins.lsp_manager")

local function format_buffer(bufnr)
  local clients = vim.lsp.get_clients({
    bufnr = bufnr,
    method = vim.lsp.protocol.Methods.textDocument_formatting,
  })

  if #clients == 0 then
    vim.notify("No LSP formatter is available for this buffer", vim.log.levels.WARN)
    return
  end

  local priority = {
    eslint = 1,
    jdtls = 2,
    lua_ls = 3,
    ts_ls = 100,
  }

  table.sort(clients, function(left, right)
    local left_priority = priority[left.name] or 50
    local right_priority = priority[right.name] or 50

    if left_priority == right_priority then
      return left.id < right.id
    end

    return left_priority < right_priority
  end)

  vim.lsp.buf.format({
    async = true,
    bufnr = bufnr,
    id = clients[1].id,
  })
end

return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      keymap = {
        preset = "default",
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "saghen/blink.cmp" },
    config = function()
      lsp_manager.prepend_mason_bin()

      local lsp_keymaps = vim.api.nvim_create_augroup("YugenLspKeymaps", { clear = true })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = lsp_keymaps,
        callback = function(event)
          local function map(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = event.buf, desc = desc })
          end

          map("gd", vim.lsp.buf.definition, "Go to definition")
          map("gD", vim.lsp.buf.declaration, "Go to declaration")
          map("gr", vim.lsp.buf.references, "Find references")
          map("gi", vim.lsp.buf.implementation, "Go to implementation")
          map("K", vim.lsp.buf.hover, "Show documentation")
          map("<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          map("<leader>f", function()
            format_buffer(event.buf)
          end, "Format file")
          map("[d", function()
            vim.diagnostic.jump({ count = -1, float = true })
          end, "Previous diagnostic")
          map("]d", function()
            vim.diagnostic.jump({ count = 1, float = true })
          end, "Next diagnostic")
        end,
      })

      vim.lsp.config("lua_ls", {
        root_dir = function(bufnr, on_dir)
          local path = vim.api.nvim_buf_get_name(bufnr)
          if path == "" then
            return
          end

          path = vim.fs.normalize(path)

          local root = vim.fs.root(path, {
            ".emmyrc.json",
            ".luarc.json",
            ".luarc.jsonc",
          }) or vim.fs.root(path, {
            ".luacheckrc",
            ".stylua.toml",
            "stylua.toml",
            "selene.toml",
            "selene.yml",
          }) or vim.fs.root(path, { ".git" })

          local home = vim.fs.normalize(vim.uv.os_homedir() or "")
          if root and vim.fs.normalize(root) == home then
            root = nil
          end

          local config_root = vim.fs.normalize(vim.fn.stdpath("config"))
          if not root and (path == config_root or vim.startswith(path, config_root .. "/")) then
            root = config_root
          end

          if not root then
            local file_directory = vim.fs.dirname(path)
            if file_directory and vim.fs.normalize(file_directory) ~= home then
              root = file_directory
            end
          end

          if root then
            on_dir(root)
          end
        end,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            completion = {
              callSnippet = "Replace",
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
          },
        },
      })

      vim.lsp.config("pyright", {
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      })

      vim.lsp.config("qmlls", {
        -- Prefer Arch's Qt server so it uses the installed Qt libraries and QML modules.
        cmd = { vim.fn.executable("qmlls6") == 1 and "qmlls6" or "qmlls" },
        root_markers = { ".qmlls.ini", "CMakeLists.txt", ".git" },
      })

      vim.lsp.enable(lsp_manager.lsp_names())
    end,
  },
}
