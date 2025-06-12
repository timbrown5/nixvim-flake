local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	vim.notify("which-key not loaded", vim.log.levels.WARN)
	return
end

which_key.setup({
	preset = "modern",
	delay = function(ctx)
		return ctx.plugin and 0 or 200
	end,
	filter = function(mapping)
		return true
	end,
	spec = {},
	notify = true,
	triggers = {
		{ "<auto>", mode = "nxso" },
	},
	defer = {
		gc = true,
		["g"] = true,
	},
	plugins = {
		marks = true,
		registers = true,
		spelling = {
			enabled = true,
			suggestions = 20,
		},
		presets = {
			operators = true,
			motions = true,
			text_objects = true,
			windows = true,
			nav = true,
			z = true,
			g = true,
		},
	},
	win = {
		border = "single",
		position = "bottom",
		margin = { 1, 0, 1, 0 },
		padding = { 1, 2, 1, 2 },
		winblend = 0,
		zindex = 1000,
	},
	layout = {
		width = { min = 20 },
		spacing = 3,
	},
	keys = {
		scroll_down = "<c-d>",
		scroll_up = "<c-u>",
	},
	sort = { "local", "order", "group", "alphanum", "mod" },
	expand = 0,
	replace = {
		key = {
			function(key)
				return require("which-key.view").format(key)
			end,
		},
		desc = {
			{ "<Plug>%(.*)%(", "%1" },
			{ "^%+", "" },
			{ "<[cC]md>", "" },
			{ "<[cC][rR]>", "" },
			{ "<[sS]ilent>", "" },
			{ "^lua%s+", "" },
			{ "^call%s+", "" },
			{ "^:%s*", "" },
		},
	},
	icons = {
		breadcrumb = "»",
		separator = "➜",
		group = "+",
		ellipsis = "…",
		mappings = true,
		rules = {},
		colors = true,
		keys = {
			Up = " ",
			Down = " ",
			Left = " ",
			Right = " ",
			C = "󰘴 ",
			M = "󰘵 ",
			D = "󰘳 ",
			S = "󰘶 ",
			CR = "󰌑 ",
			Esc = "󱊷 ",
			ScrollWheelDown = "󱕐 ",
			ScrollWheelUp = "󱕑 ",
			NL = "󰌑 ",
			BS = "󰁮",
			Space = "󱁐 ",
			Tab = "󰌒 ",
			F1 = "󱊫",
			F2 = "󱊬",
			F3 = "󱊭",
			F4 = "󱊮",
			F5 = "󱊯",
			F6 = "󱊰",
			F7 = "󱊱",
			F8 = "󱊲",
			F9 = "󱊳",
			F10 = "󱊴",
			F11 = "󱊵",
			F12 = "󱊶",
		},
	},
	show_help = true,
	show_keys = true,
	disable = {
		ft = {},
		bt = {},
	},
	debug = false,
})

-- Add group definitions using the new spec format
which_key.add({
	-- Only group definitions needed
	{ "<leader>b", group = "Buffer" },
	{ "<leader>c", group = "Code" },
	{ "<leader>d", group = "Diagnostics/Delete" },
	{ "<leader>D", group = "Debug" },
	{ "<leader>f", group = "Find/Files" },
	{ "<leader>g", group = "Git" },
	{ "<leader>l", group = "LSP" },
	{ "<leader>m", group = "Mini" },
	{ "<leader>p", group = "Precognition" },
	{ "<leader>s", group = "Split/Snacks" },
	{ "<leader>t", group = "Terminal/Tabs" },
	{ "<leader>w", group = "Window" },
	{ "<leader>z", group = "Fold" },

	-- Subgroups
	{ "<leader>lw", group = "Workspace" },
	{ "<leader>lg", group = "Goto" },
})
