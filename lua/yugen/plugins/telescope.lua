return {
  'nvim-telescope/telescope.nvim',
  version = '*',
  dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
      local telescope = require("telescope")

      telescope.setup({
          extensions = {
              ["ui-select"] = require("telescope.themes").get_dropdown({}),

              fzf = {
                  fuzzy = true,
                  override_generic_sorter = true,
                  override_file_sorter = true,
                  case_mode = "smart_case",
              }
          }
      })

      telescope.load_extension("ui-select")
      telescope.load_extension("fzf")

      local builtin = require("telescope.builtin")
      vim.keymap.set('n', '<leader>p', builtin.find_files, {})
      vim.keymap.set('n', '<leader>pp', builtin.live_grep, {})
  end,
}
