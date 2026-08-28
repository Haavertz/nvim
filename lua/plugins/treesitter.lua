local parsers = {
  "bash",
  "css",
  "html",
  "java",
  "javascript",
  "json",
  "lua",
  "markdown",
  "python",
  "rust",
  "sql",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "xml",
  "yaml",
}

return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local treesitter = require("nvim-treesitter")
    local configured = {}

    for _, parser in ipairs(parsers) do
      configured[parser] = true
    end

    treesitter.install(parsers)

    local group = vim.api.nvim_create_augroup("InstallTreesitter", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      callback = function(event)
        local language = vim.treesitter.language.get_lang(vim.bo[event.buf].filetype)
        if language and configured[language] then
          pcall(vim.treesitter.start, event.buf, language)
        end
      end,
    })
  end,
}
