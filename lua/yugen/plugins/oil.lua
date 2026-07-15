  return {
  "stevearc/oil.nvim",
  opts = {
    columns = {
      "size",
      "icon",
      "mtime",
    },
    keymaps = {
      ["g?"] = { "actions.show_help", mode = "n" },
      ["<CR>"] = "actions.select",
      ["<C-s>"] = { "actions.select", opts = { vertical = true } },
      ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
      ["<C-t>"] = { "actions.select", opts = { tab = true } },
      ["<C-p>"] = "actions.preview",
      ["q"] = { "actions.close", mode = "n" },
      ["<C-l>"] = "actions.refresh",
      ["-"] = { "actions.parent", mode = "n" },
      ["_"] = { "actions.open_cwd", mode = "n" },
      ["`"] = { "actions.cd", mode = "n" },
      ["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
      ["gs"] = { "actions.change_sort", mode = "n" },
      ["gx"] = "actions.open_external",
      ["g."] = { "actions.toggle_hidden", mode = "n" },
      ["g\\"] = { "actions.toggle_trash", mode = "n" },
    },
    skip_confirm_for_simple_edits = true,
    lsp_file_methods = {
      enabled = true,
      timeout_ms = 1000,
      autosave_changes = true,
    },
    confirmation = {
      max_width = 0.3,
      min_width = { 20, 0.4 },
      max_height = 0.2,
      min_height = { 5, 0.1 },
      border = "rounded",

      win_options = {
        winblend = 0,
      },
    },
    progress = {
      max_width = 0.3,
      min_width = { 20, 0.4 },
      width = 10,
      max_height = { 5, 0.6 },
      min_height = { 3, 0.1 },
      height = 5,
      border = "rounded",

      win_options = {
        winblend = 0,
      },
    },
    float = {
      padding = 2,
      max_width = 0,
      max_height = 0,
      border = nil,

      preview_split = "right",

      win_options = {
        winblend = 0,
      },

      override = function(conf)
        return conf
      end,
    },
  },
  dependencies = {
    { "nvim-mini/mini.icons", opts = {} },
  },

  lazy = false,
}
