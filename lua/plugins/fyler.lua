return {
  "A7Lavinraj/fyler.nvim",
  branch = "stable",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    {
      "<leader>fe",
      function()
        require("fyler").toggle()
      end,
      desc = "Toggle left file explorer",
    },
  },
  opts = {
    integrations = {
      icon = "nvim_web_devicons",
    },
    views = {
      finder = {
        win = {
          kind = "split_left_most",
        },
      },
    },
  },
}
