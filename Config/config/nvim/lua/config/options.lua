-- Set leader key to space
vim.g.mapleader = " "

-- Use absolute line numbers
vim.opt.number = true
vim.opt.relativenumber = false

-- Highlight only the line number
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

-- Show tabs as ▸ and keep spaces invisible
vim.opt.list = true
vim.opt.listchars = { tab = "▸ ", space = " " }

-- Standard indentation settings
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- Enable true color support
vim.opt.termguicolors = true

-- System clipboard integration
vim.opt.clipboard = "unnamedplus"

-- Disable netrw in favor of neo-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
