return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require("nvim-treesitter").setup {
      ensure_installed = {"c", "python", "lua", "rust", "vim", "vimdoc", "toml", "bash", "bibtex", "css", "diff", "gitignore", "html", "jq", "json", "latex", "lua", "markdown", "swift", "typescript", "javascript", "tsx", "elixir"},

      highlight = {
        enable = true,
      },
    }
  end
}
