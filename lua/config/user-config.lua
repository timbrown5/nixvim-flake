-- User configuration
-- This file contains user-specific customizations

-- Custom settings
vim.opt.colorcolumn = "80"

-- Set up custom highlights
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		local colors = require("catppuccin.palettes").get_palette()

		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

		vim.api.nvim_set_hl(0, "ColorColumn", {
			bg = colors.surface0,
			blend = 50,
		})

		vim.api.nvim_set_hl(0, "LineNrActive", {
			fg = colors.blue,
			bold = true,
			italic = true,
		})

		vim.api.nvim_set_hl(0, "CursorLineNrActive", {
			fg = colors.yellow,
			bold = true,
			italic = true,
		})

		vim.api.nvim_set_hl(0, "FloatBorderActive", {
			fg = colors.blue,
			bold = true,
		})
		vim.api.nvim_set_hl(0, "FloatBorder", {
			fg = colors.surface1,
		})
	end,
})

-- Window focus management for all window types
vim.api.nvim_create_augroup("WindowFocus", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	group = "WindowFocus",
	callback = function()
		if vim.api.nvim_win_get_config(0).relative ~= "" then
			vim.wo.winhighlight = "FloatBorder:FloatBorderActive"
		else
			vim.wo.winhighlight = "LineNr:LineNrActive,CursorLineNr:CursorLineNrActive"
		end
	end,
})

vim.api.nvim_create_autocmd({ "WinLeave" }, {
	group = "WindowFocus",
	callback = function()
		vim.wo.winhighlight = ""
	end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ timeout = 200 })
	end,
})

-- Format on save for more file types
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.lua", "*.nix", "*.ts", "*.tsx", "*.js", "*.jsx" },
	callback = function()
		if not vim.g.disable_autoformat and not vim.b.disable_autoformat then
			vim.lsp.buf.format({ async = false })
		end
	end,
})

-- Diagnostics config with nice prefix
vim.diagnostic.config({
	virtual_text = {
		prefix = "●", -- Nice circle prefix for inline diagnostics
	},
	severity_sort = true,
	float = {
		border = "rounded",
		source = "always",
	},
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
	bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
	vim.notify("Format enabled", vim.log.levels.INFO)
end, {
	desc = "Re-enable autoformat-on-save",
})

local function setup_transparent_window_highlighting()
	local ok, catppuccin = pcall(require, "catppuccin.palettes")
	if ok then
		local colors = catppuccin.get_palette("macchiato")

		-- Only dim text, not background (preserves transparency)
		vim.api.nvim_set_hl(0, "NormalNC", {
			fg = colors.overlay0, -- Dimmer text for inactive windows
			bg = "NONE", -- Keep transparent background
		})

		vim.api.nvim_set_hl(0, "LineNrNC", {
			fg = colors.surface0, -- Dimmer line numbers
			bg = "NONE",
		})

		-- Dim other UI elements in inactive windows
		vim.api.nvim_set_hl(0, "SignColumnNC", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "FoldColumnNC", { bg = "NONE" })
	end
end

-- Apply on startup and colorscheme changes
vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
	group = vim.api.nvim_create_augroup("TransparentWindowHighlight", { clear = true }),
	callback = setup_transparent_window_highlighting,
})
