-- User configuration
-- This file contains user-specific customizations

-- Custom settings
vim.opt.colorcolumn = "80"

-- Set up custom highlights
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	end
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ timeout = 200 })
	end
})

-- Format on save for more file types
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.lua", "*.nix", "*.ts", "*.tsx", "*.js", "*.jsx" },
	callback = function()
		if not vim.g.disable_autoformat and not vim.b.disable_autoformat then
			vim.lsp.buf.format({ async = false })
		end
	end
})

-- Diagnostics config with nice prefix
vim.diagnostic.config({
	virtual_text = {
		prefix = "●" -- Nice circle prefix for inline diagnostics
	},
	severity_sort = true,
	float = {
		border = "rounded",
		source = "always"
	}
})

-- Configure Snacks if available
local snacks_ok, snacks = pcall(require, "snacks")
if snacks_ok then
	-- Any runtime Snacks configuration can go here
	-- Most config is already in the Nix file
end

-- Custom commands for format toggling
vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		-- FormatDisable! will disable formatting just for this buffer
		vim.b.disable_autoformat = true
		vim.notify("Format disabled for buffer", vim.log.levels.INFO)
	else
		vim.g.disable_autoformat = true
		vim.notify("Format disabled globally", vim.log.levels.INFO)
	end
end, {
	desc = "Disable autoformat-on-save",
	bang = true
})

vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
	vim.notify("Format enabled", vim.log.levels.INFO)
end, {
	desc = "Re-enable autoformat-on-save"
})
