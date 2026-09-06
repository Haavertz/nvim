return {
  "knownasnaffy/himalaya.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  opts = {
    icons_enabled = false, -- set to true to use nerd font icons
    wrap_folder_navigation = true,
  },
  keys = {
    { "<leader>oh", "<Cmd>Himalaya<CR>", desc = "[O]pen [H]imalaya" },
  },
}
