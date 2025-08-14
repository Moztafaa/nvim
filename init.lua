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
