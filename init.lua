-- Windows PowerShell configuration for treesitter
-- if vim.fn.has("win32") == 1 then
--   vim.opt.shell = "pwsh"
--   vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
--   vim.opt.shellquote = ""
--   vim.opt.shellxquote = ""
-- end
--
-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")



if vim.g.vscode then
    -- VSCode extension
    vim.opt.timeoutlen = 300
    vim.g.mapleader = " "
    -- Normal mode
    vim.keymap.set('n', '<Space>', '<Cmd>call VSCodeNotify("whichkey.show")<CR>', { silent = true })
    -- Visual mode
    vim.keymap.set('v', '<Space>', '<Cmd>call VSCodeNotify("whichkey.show")<CR>', { silent = true })
else
    -- ordinary Neovim
    vim.opt.timeoutlen = 300
    vim.g.mapleader = " "
end
