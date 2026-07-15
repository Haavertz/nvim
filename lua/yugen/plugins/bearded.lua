return {
  "Ferouk/bearded-nvim",
  name = "bearded",
  priority = 1000,
  build = function()
    -- Generate helptags so :h bearded-theme works
    local doc = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy", "bearded", "doc")
    pcall(vim.cmd, "helptags " .. doc)
  end,
  config = function()
    require("bearded").setup({
        flavor = "arc-blueberry", -- any flavor slug
        transparent = false,
        bold = true,
        italic = true,
        terminal_colors = true,
        on_highlights = nil,
    })
    vim.cmd.colorscheme("bearded")
  end,
}
