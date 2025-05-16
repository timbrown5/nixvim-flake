-- FALLBACK KEYBINDINGS
-- These are minimal keybindings that will work even if NvChad fails to load
-- They should NOT duplicate keys defined in modules/options.nix

-- Helper function for easier keymapping
local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better paste
map("v", "p", "\"_dP", { desc = "Paste without yanking" })

-- Center cursor after jumps
map("n", "<C-d>", "<C-d>zz", { desc = "Jump down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Jump up and center" })
map("n", "n", "nzzzv", { desc = "Next search result and center" })
map("n", "N", "Nzzzv", { desc = "Previous search result and center" })

-- Load deferred keybindings if available
local ok, deferred = pcall(require, "keybinds.deferred")
if not ok then
	vim.notify("Deferred keybindings not loaded in fallback mode", vim.log.levels.INFO)
end

-- Return the module
return {
	-- We can add functions or variables here if needed
	setup = function()
		vim.notify("Basic keybindings loaded successfully", vim.log.levels.INFO)
	end
}
