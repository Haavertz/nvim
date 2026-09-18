return {
  "Ferouk/bearded-nvim",
  name = "bearded",
  priority = 1000,
  config = function()
    require("bearded").setup({
      flavor = "arc-blueberry",
    })
    vim.cmd.colorscheme("bearded")
  end,
}

-- https://github.com/CosecSecCot/cosec-twilight.nvim
-- return {
--     "CosecSecCot/cosec-twilight.nvim",
--     lazy = false,
--     priority = 1000,
--     dependencies = "rktjmp/lush.nvim",
-- }
