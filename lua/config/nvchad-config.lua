-- Set essential NvChad variables first
vim.g.base46_cache = vim.fn.stdpath("data") .. "/nvchad/base46/"
vim.g.mapleader = " "

-- Create required directories
vim.fn.mkdir(vim.fn.stdpath("data") .. "/nvchad/base46", "p")

-- Load base theme configuration
vim.g.nvchad_theme = "catppuccin"

-- Load our primary config
local ok = pcall(function()
	-- Load base configuration
	if vim.fn.filereadable(vim.g.base46_cache .. "defaults") == 1 then
		dofile(vim.g.base46_cache .. "defaults")
	end

	-- Load statusline if available
	if vim.fn.filereadable(vim.g.base46_cache .. "statusline") == 1 then
		dofile(vim.g.base46_cache .. "statusline")
	end
end)

-- Load user configurations
require("config.user-config")

-- Load keybindings
vim.schedule(function()
	require("config.keybindings")
end)
