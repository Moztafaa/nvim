-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- vim.opt_local.tabstop = 4 -- 1 tab = 4 spaces
--vim.opt_local.shiftwidth = 4 -- Auto-indent uses 4 spaces
--vim.opt_local.softtabstop = 4 -- Backspace deletes 4 spaces
--vim.opt_local.expandtab = true -- Convert tabs to spaces

vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting
vim.o.title = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.ignorecase = true
vim.o.smarttab = true
