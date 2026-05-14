return {
  "knownasnaffy/himalaya.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  opts = {
    sidebar = {
      width = 30,
    },
    split_ratio = 0.4, -- email list takes 40% when split
    wrap_folder_navigation = true, -- wrap to first/last when navigating
    icons_enabled = true,
    keymaps = {
      listing = {
        ["gq"] = "close",
        ["]f"] = "next_folder",
        ["[f"] = "previous_folder",
        ["gF"] = "folder_picker",

        ["<leader>r"] = function()
          require("himalaya.folder").reload()
          vim.notify("Reloaded!", vim.log.levels.INFO)
        end,

        ["<Tab>"] = "next_page",
        ["<S-Tab>"] = "previous_page",

        ["h"] = "previous_page",
        ["l"] = "next_page",

        ["<CR>"] = "open_email",
      },

      email = {
        ["q"] = "close_email",
      },
    }
  },
}
