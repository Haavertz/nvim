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
        require('mason').setup()
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
          show_on_keyword = false,
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
      
      -- slqs
      vim.lsp.config('sqls', {
        settings = {
          sqls = {},
        },
      })


      -- LSP Enable

      vim.lsp.enable("lua_ls")
      vim.lsp.enable("pyright")
      vim.lsp.enable("emmet_language_server")
      vim.lsp.enable("sqls")

    end, 
  }
}

