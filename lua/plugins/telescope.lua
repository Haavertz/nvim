return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    local telescope = require("telescope")

    telescope.setup({
      extensions = {
        -- ["ui-select"] = require("telescope.themes").get_dropdown({}),
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
      pickers = {
         colorscheme {
            enable_preview = true,
         },
      },
      find_files = {
         hidden = true,
         find_command = {
            "!(.git/*,.next/*,graphify-out/*,nodes-modules/*)",
            "--path-separator",
            "/"
         }
      }
    })

    vim.keymap.set("n", "<leader>jg", ":lua require'telescope.builtin'.find_files(require('telescope.themes').get_cursor({}))<cr>")

    telescope.load_extension("ui-select")
    telescope.load_extension("fzf")
  end,

  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
    {
      "<leader>fc",
      function()
        require("telescope.builtin").find_files({
          cwd = vim.fn.stdpath("config"),
        })
      end,
      desc = "Find Neovim config files",
    },
  },

}
