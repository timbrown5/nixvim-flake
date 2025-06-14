vim.opt.colorcolumn = "80"

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		local ok, catppuccin = pcall(require, "catppuccin.palettes")
		if not ok then
			vim.notify("Catppuccin palettes not available, skipping color customization", vim.log.levels.WARN)
			return
		end

		local colors = catppuccin.get_palette()

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

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ timeout = 200 })
	end,
})

vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
	},
	severity_sort = true,
	float = {
		border = "rounded",
		source = "always",
	},
})

local snacks_ok, snacks = pcall(require, "snacks")
if snacks_ok then
	-- Snacks configuration
end

local function setup_transparent_window_highlighting()
	local ok, catppuccin = pcall(require, "catppuccin.palettes")
	if not ok then
		vim.notify("Catppuccin not available for transparent window highlighting", vim.log.levels.DEBUG)
		return
	end

	local colors = catppuccin.get_palette("macchiato")

	vim.api.nvim_set_hl(0, "NormalNC", {
		fg = colors.overlay0,
		bg = "NONE",
	})

	vim.api.nvim_set_hl(0, "LineNrNC", {
		fg = colors.surface0,
		bg = "NONE",
	})

	vim.api.nvim_set_hl(0, "SignColumnNC", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "FoldColumnNC", { bg = "NONE" })
end

vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
	group = vim.api.nvim_create_augroup("TransparentWindowHighlight", { clear = true }),
	callback = setup_transparent_window_highlighting,
})
