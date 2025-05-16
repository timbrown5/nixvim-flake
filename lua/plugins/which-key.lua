local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	vim.notify("which-key not loaded", vim.log.levels.WARN)
	return
end

-- Ultra minimal which-key setup
which_key.setup({
	ignore_missing = true, -- This is the key setting to silence most warnings
})

-- Register only the main groups, one time, using the old format
which_key.register({
	{ "<leader>D",  group = "Debug" },
	{ "<leader>b",  group = "Buffer" },
	{ "<leader>c",  group = "Code" },
	{ "<leader>d",  group = "Diagnostics/Delete" },
	{ "<leader>f",  group = "Find/Files" },
	{ "<leader>g",  group = "Git" },
	{ "<leader>l",  group = "LSP" },
	{ "<leader>lw", group = "Workspace" },
	{ "<leader>m",  group = "Mini" },
	{ "<leader>s",  group = "Split/Snacks" },
	{ "<leader>t",  group = "Terminal/Tabs" },
	{ "<leader>w",  group = "Window" },
	{ "<leader>z",  group = "Fold" },
})
