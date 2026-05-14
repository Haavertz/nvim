-- sudo pacman -S xclip

local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 5
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 2
vim.opt.breakindent = true
vim.opt.smartindent = true
vim.opt.undofile = true
vim.opt.mouse = "a"
vim.opt.timeoutlen = 700
vim.opt.list = false
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.hlsearch = true

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })
vim.keymap.set("n", "<leader><leader>", "<cmd>so %<CR>", { desc = "Reload current file" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })
vim.keymap.set("n", "<C-c>", ":noh<CR>", { desc = "Clear search hl", silent = true })
vim.keymap.set("v", "<", "<gv", opts) -- indent with select text 
vim.keymap.set("v", ">", ">gv", opts)
vim.keymap.set("n", "<leader>sh", "<C-w>v", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>sv", "<C-w>s", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) 
vim.keymap.set("n", "<leader>sc", "<cmd>close<CR>", { desc = "Close current split" })
vim.keymap.set("n", "Q", "<nop>")

vim.api.nvim_set_hl(0, "yugen", {
  bg = "#00002a",  -- bg
  fg = "#ffffff",  -- fg
})
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight on yank",
  callback = function()
    vim.hl.on_yank({ 
	higroup = "Visual",
	timeout = 200 
    })
  end,
})

