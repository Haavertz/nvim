return {
 {
    "folke/persistence.nvim",
    event = "BufReadPre",

    opts = {
      dir = vim.fn.stdpath("state") .. "/sessions/",
      need = 1,
      branch = true,
    },

    config = function(_, opts)
      require("persistence").setup(opts)

      -- load the session for the current directory
      vim.keymap.set("n", "<leader>qs", function()
        require("persistence").load()
      end, { desc = "Restore session" })

      -- select a session to load
      vim.keymap.set("n", "<leader>qS", function()
        require("persistence").select()
      end, { desc = "Select session" })

      -- load the last session
      vim.keymap.set("n", "<leader>ql", function()
        require("persistence").load({ last = true })
      end, { desc = "Restore last session" })

      -- stop Persistence
      vim.keymap.set("n", "<leader>qd", function()
        require("persistence").stop()
      end, { desc = "Stop persistence" })
    end,
  },
}
