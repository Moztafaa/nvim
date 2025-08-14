-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Format on Idle toggle keymap
vim.keymap.set("n", "<leader>cFI", function()
  _G.toggle_format_on_idle()
end, { desc = "Toggle Format on Idle" })
