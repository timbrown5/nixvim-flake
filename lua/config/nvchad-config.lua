-- NvChad initialization
-- Bootstrap NvChad
vim.g.base46_cache = vim.fn.stdpath("data") .. "/nvchad/base46/"
vim.g.nvchad_theme = "catppuccin"

-- Load NvChad
local nvchad_ok, nvchad = pcall(require, "nvchad")
if nvchad_ok then
  nvchad.load_config()
end

-- Load NvChad UI
local ui_ok, nvchad_ui = pcall(require, "nvchad")
if ui_ok then
  -- Set up statusline
  vim.opt.statusline = '%!v:lua.require("nvchad.statusline.default").run()'
  
  -- Set up tabufline
  vim.opt.tabline = '%!v:lua.require("nvchad.tabufline.modules").run()'
end

-- Load NvChad mappings
local mappings_ok, _ = pcall(require, "core.mappings")
if not mappings_ok then
  vim.notify("Failed to load NvChad mappings", vim.log.levels.WARN)
end

-- Enable blink.cmp icons
vim.g.enable_mini_icons = false  -- Use Nerd Font icons instead
