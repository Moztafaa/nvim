-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Format on Idle functionality
-- Global variable to track format on idle state
_G.format_on_idle_enabled = false

-- Timer to handle format on idle
local format_timer = nil
local format_delay = 2000 -- 2 seconds delay

-- Function to format buffer
local function format_buffer()
  if not _G.format_on_idle_enabled then
    return
  end
  
  local buf = vim.api.nvim_get_current_buf()
  local filetype = vim.api.nvim_buf_get_option(buf, "filetype")
  
  -- Only format specific file types
  local supported_filetypes = {
    "cs", "javascript", "typescript", "lua", "python", "go", "rust",
    "c", "cpp", "java", "json", "yaml", "html", "css", "scss", "markdown"
  }
  
  local should_format = false
  for _, ft in ipairs(supported_filetypes) do
    if filetype == ft then
      should_format = true
      break
    end
  end
  
  if should_format and vim.api.nvim_buf_get_option(buf, "modified") then
    -- Try LSP formatting first, then fall back to conform.nvim
    local clients = vim.lsp.buf_get_clients(buf)
    if #clients > 0 then
      vim.lsp.buf.format({ async = true })
    elseif pcall(require, "conform") then
      require("conform").format({ async = true })
    end
  end
end

-- Function to reset the format timer
local function reset_format_timer()
  if format_timer then
    format_timer:stop()
    format_timer:close()
  end
  
  if _G.format_on_idle_enabled then
    format_timer = vim.loop.new_timer()
    format_timer:start(format_delay, 0, vim.schedule_wrap(format_buffer))
  end
end

-- Function to toggle format on idle
_G.toggle_format_on_idle = function()
  _G.format_on_idle_enabled = not _G.format_on_idle_enabled
  
  if _G.format_on_idle_enabled then
    vim.notify("Format on Idle: ENABLED", vim.log.levels.INFO)
    reset_format_timer()
  else
    vim.notify("Format on Idle: DISABLED", vim.log.levels.INFO)
    if format_timer then
      format_timer:stop()
      format_timer:close()
      format_timer = nil
    end
  end
end

-- Create autocommands for format on idle
vim.api.nvim_create_augroup("FormatOnIdle", { clear = true })

-- Reset timer on text changes
vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
  group = "FormatOnIdle",
  callback = function()
    if _G.format_on_idle_enabled then
      reset_format_timer()
    end
  end,
})

-- Clean up timer when leaving buffer
vim.api.nvim_create_autocmd("BufLeave", {
  group = "FormatOnIdle",
  callback = function()
    if format_timer then
      format_timer:stop()
      format_timer:close()
      format_timer = nil
    end
  end,
})

-- Reset timer when entering buffer
vim.api.nvim_create_autocmd("BufEnter", {
  group = "FormatOnIdle",
  callback = function()
    if _G.format_on_idle_enabled then
      reset_format_timer()
    end
  end,
})
