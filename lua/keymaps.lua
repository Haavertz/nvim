local km = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 3
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.g.markdown_recommended_style = 0
vim.opt.breakindent = true
vim.opt.smartindent = true
vim.opt.undofile = true
vim.opt.mouse = "a"
vim.opt.timeoutlen = 700
vim.opt.list = false
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.hlsearch = true

-- remaps

km("n", "mk", ":lua require('render-markdown').buf_toggle()<CR>")
km("n", "<leader><leader>", ":Alpha <CR>")
km("n", "<C-d>", "<C-d>zz")
km("n", "<C-u>", "<C-u>zz")

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

-- indent on sides 
km("v", "<", "<gv", { noremap = true, silent = true })
km("v", ">", ">gv", { noremap = true, silent = true })

-- see error
km("n", "<leader>e", vim.diagnostic.open_float)

