local function safe_keymap(mode, key, action, opts)
	local ok, error = pcall(vim.keymap.set, mode, key, action, opts)
	if not ok then
		vim.notify("Failed to set keymap " .. key .. ": " .. tostring(error), vim.log.levels.ERROR)
	end
end

local function setup_indent_colors()
	local ok, catppuccin = pcall(require, "catppuccin.palettes")
	if not ok then
		vim.notify("Catppuccin not available for indent colors, using defaults", vim.log.levels.DEBUG)
		return
	end

	local colors = catppuccin.get_palette("macchiato")
	vim.api.nvim_set_hl(0, "SnacksIndent", { fg = colors.surface0 })
	vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = colors.blue })
	vim.api.nvim_set_hl(0, "SnacksIndentChunk", { fg = colors.lavender })
end

vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
	callback = setup_indent_colors,
})

safe_keymap("n", "<C-n>", function()
	local ok, snacks = pcall(require, "snacks")
	if ok and snacks.explorer then
		snacks.explorer()
	else
		vim.notify("Snacks explorer not available", vim.log.levels.WARN)
	end
end, { desc = "Toggle file explorer" })

safe_keymap("n", "<leader>/", function()
	local ok, snacks = pcall(require, "snacks")
	if ok and snacks.explorer then
		snacks.explorer()
	else
		vim.notify("Snacks explorer not available", vim.log.levels.WARN)
	end
end, { desc = "Open file explorer" })

-- Notification keymaps (moved to <leader>n namespace)
safe_keymap("n", "<leader>nh", function()
	local ok, snacks = pcall(require, "snacks")
	if ok and snacks.notifier then
		snacks.notifier.show_history()
	else
		vim.notify("Snacks notifier not available", vim.log.levels.WARN)
	end
end, { desc = "Show notification history" })

safe_keymap("n", "<leader>nd", function()
	local ok, snacks = pcall(require, "snacks")
	if ok and snacks.notifier then
		snacks.notifier.hide()
	else
		vim.notify("Snacks notifier not available", vim.log.levels.WARN)
	end
end, { desc = "Dismiss notifications" })

safe_keymap("n", "<leader>nt", function()
	local ok, snacks = pcall(require, "snacks")
	if ok and snacks.notifier then
		snacks.notifier.notify("Test notification", { level = "info" })
	else
		vim.notify("Snacks notifier not available", vim.log.levels.WARN)
	end
end, { desc = "Test notification" })

-- View keymaps (moved to <leader>v namespace)
safe_keymap("n", "<leader>vi", function()
	local ok, snacks = pcall(require, "snacks")
	if ok and snacks.image then
		snacks.image.show()
	else
		vim.notify("Snacks image preview not available", vim.log.levels.WARN)
	end
end, { desc = "View image preview" })

safe_keymap("n", "<leader>vc", function()
	local ok, snacks = pcall(require, "snacks")
	if ok and snacks.image then
		snacks.image.show_clipboard()
	else
		vim.notify("Snacks image preview not available", vim.log.levels.WARN)
	end
end, { desc = "View clipboard image" })

-- Fuzzy finder keymaps (unchanged)
safe_keymap("n", "<leader>ff", function()
	local ok, snacks = pcall(require, "snacks")
	if ok and snacks.picker then
		snacks.picker.files()
	else
		vim.notify("Snacks picker not available", vim.log.levels.WARN)
	end
end, { desc = "Find files" })

safe_keymap("n", "<leader>fw", function()
	local ok, snacks = pcall(require, "snacks")
	if ok and snacks.picker then
		snacks.picker.grep()
	else
		vim.notify("Snacks picker not available", vim.log.levels.WARN)
	end
end, { desc = "Live grep" })

safe_keymap("n", "<leader>fb", function()
	local ok, snacks = pcall(require, "snacks")
	if ok and snacks.picker then
		snacks.picker.buffers()
	else
		vim.notify("Snacks picker not available", vim.log.levels.WARN)
	end
end, { desc = "Find buffers" })

safe_keymap("n", "<leader>fh", function()
	local ok, snacks = pcall(require, "snacks")
	if ok and snacks.picker then
		snacks.picker.help()
	else
		vim.notify("Snacks picker not available", vim.log.levels.WARN)
	end
end, { desc = "Find help" })

safe_keymap("n", "<leader>fr", function()
	local ok, snacks = pcall(require, "snacks")
	if ok and snacks.picker then
		snacks.picker.recent()
	else
		vim.notify("Snacks picker not available", vim.log.levels.WARN)
	end
end, { desc = "Recent files" })

safe_keymap("n", "<leader>fd", function()
	local ok, snacks = pcall(require, "snacks")
	if ok and snacks.picker then
		snacks.picker.diagnostics()
	else
		vim.notify("Snacks picker not available", vim.log.levels.WARN)
	end
end, { desc = "Find diagnostics" })

safe_keymap("n", "<leader>fs", function()
	local ok, snacks = pcall(require, "snacks")
	if ok and snacks.picker then
		snacks.picker.symbols()
	else
		vim.notify("Snacks picker not available", vim.log.levels.WARN)
	end
end, { desc = "Find symbols" })

safe_keymap("n", "<leader>fc", function()
	local ok, snacks = pcall(require, "snacks")
	if ok and snacks.picker then
		snacks.picker.commands()
	else
		vim.notify("Snacks picker not available", vim.log.levels.WARN)
	end
end, { desc = "Find commands" })

safe_keymap("n", "<leader>fk", function()
	local ok, snacks = pcall(require, "snacks")
	if ok and snacks.picker then
		snacks.picker.keymaps()
	else
		vim.notify("Snacks picker not available", vim.log.levels.WARN)
	end
end, { desc = "Find keymaps" })
