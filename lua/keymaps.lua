local M = {}

local km = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 7
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.breakindent = true
vim.opt.smartindent = true
vim.opt.undofile = true
vim.opt.mouse = "a"
vim.opt.timeoutlen = 700
vim.opt.list = false
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.hlsearch = true

-- move selections
km("v", "J", ":m '>+1<CR>gv=gv") 
km("v", "K", ":m '<-2<CR>gv=gv") 
km("n", "<leader>t", "bv~")

-- window manips
km("n", "=", [[<cmd>vertical resize +5<cr>]])
km("n", "-", [[<cmd>vertical resize -5<cr>]])
km("n", "+", [[<cmd>horizontal resize +5<cr>]])
km("n", "^", [[<cmd>horizontal resize +5<cr>]])
km("n", "<leader>sh", ":split<CR>")
km("n", "<leader>sv", ":vsplit<CR>")
km("n", "<leader>sc", ":clo<CR>")

-- see error
km("n", "<leader>e", vim.diagnostic.open_float)

-- go to errors
km("n", "[e", vim.diagnostic.goto_next)
km("n", "]e", vim.diagnostic.goto_next)

return M
