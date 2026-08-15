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
