return {
  {
    "mason-org/mason.nvim",
    opts = {
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            },
        },
    },
    config = function()
        require("mason").setup()

        vim.api.nvim_create_user_command("YugenInstallJava", function()
          vim.cmd("MasonInstall jdtls java-debug-adapter java-test google-java-format")
        end, {
          desc = "Install Java LSP, debugger, tests, and formatter",
          force = true,
        })
    end,
  },
  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',
    build = "cargo build --release",
    opts = {
      
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {

        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },

        ["<CR>"] = { "accept", "fallback" },

        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },

        ["<C-e>"] = { "hide", "fallback" },

        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
      },


      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        nerd_font_variant = 'mono'
      },

      completion = {
        trigger = {
          show_on_keyword = true,
          show_on_trigger_character = true,
        },
        documentation = {
          auto_show = false,
        },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },

    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      vim.lsp.config('*', {
            capabilities = capabilities,
      })

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
            vim.lsp.buf.format({ async = true })
          end, "Format file")
          map("[d", function()
            vim.diagnostic.jump({ count = -1, float = true })
          end, "Previous diagnostic")
          map("]d", function()
            vim.diagnostic.jump({ count = 1, float = true })
          end, "Next diagnostic")
        end,
      })

      -- local augroup = vim.api.nvim_create_augroup("LspDiagnosticsHold", { clear = true })
      -- local virtual_text_enabled = true
      -- vim.o.updatetime = 350

      -- Configure and enable LSP servers
      -- lua_ls
      vim.lsp.config("lua_ls", {
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

      -- eslint
      vim.lsp.config("eslint", {})
      vim.lsp.enable("eslint")

      -- pyright
      vim.lsp.config("pyright", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            }, 
            completion = {
              callSnippet = "Replace",
            },
          }
        }
      })

      -- emmet_language_server
      vim.lsp.config("emmet_language_server", {
          filetypes = {
              "css",
              "html",
              "javascript",
              "javascriptreact",
              "less",
              "sass",
              "scss",
              "typescriptreact",
              "sql",
          },
          init_options = {
              includeLanguages = {},
              excludeLanguages = {},
              extensionsPath = {},
              preferences = {},
              showAbbreviationSuggestions = true,
              showExpandedAbbreviation = "always",
              showSuggestionsAsSnippets = false,
              syntaxProfiles = {},
              variables = {},
          },
      })

      -- html
      vim.lsp.config("html", {})

      -- cssls
      vim.lsp.config("cssls", {})

      -- ts_ls
      vim.lsp.config("ts_ls", {})


      -- LSP Enable
      vim.lsp.enable("lua_ls")
      vim.lsp.enable("pyright")
      vim.lsp.enable("emmet_language_server")

      vim.lsp.enable("html")
      vim.lsp.enable("cssls")
      vim.lsp.enable("ts_ls")

    end,
  }
}
