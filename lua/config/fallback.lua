-- Fallback configuration when NvChad doesn't load properly
-- This ensures we have a working editor even if NvChad fails

-- Set basic colorscheme
vim.cmd [[
  try
    colorscheme catppuccin-macchiato
  catch
    colorscheme habamax
  endtry
]]

-- Basic statusline if NvChad's isn't available
if vim.o.statusline == "" then
	vim.o.statusline = " %f %m %= %l:%c "
end

-- Ensure leader key is set
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load keybindings with error handling
local ok, keybinds = pcall(require, 'keybinds')
if not ok then
	vim.notify("Unable to load keybindings in fallback mode", vim.log.levels.WARN)
end
