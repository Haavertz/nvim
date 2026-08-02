return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      { "<leader>s", group = "Splits" },
      { "<leader>q", group = "Sessions" },
      { "<leader>d", group = "Debug" },
      { "<leader>j", group = "Java" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = true })
      end,
      desc = "Show keymaps",
    },
  },
}
