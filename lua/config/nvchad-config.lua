-- Set essential NvChad variables first
vim.g.base46_cache = vim.fn.stdpath("data") .. "/nvchad/base46/"

-- Create required directories
vim.fn.mkdir(vim.fn.stdpath("data") .. "/nvchad/base46", "p")

-- Load base theme configuration
vim.g.nvchad_theme = "catppuccin"

-- Add safety check before accessing cache
local ok = pcall(function()
  -- Check if cache directory and files exist before loading
  if vim.fn.isdirectory(vim.g.base46_cache) == 1 then
    if vim.fn.filereadable(vim.g.base46_cache .. "defaults") == 1 then
      dofile(vim.g.base46_cache .. "defaults")
    end

    if vim.fn.filereadable(vim.g.base46_cache .. "statusline") == 1 then
      dofile(vim.g.base46_cache .. "statusline")
    end
  end
end)

if not ok then
  vim.notify("NvChad cache not available, using fallback", vim.log.levels.WARN)
end

-- Load user configurations
require("config.user-config")
