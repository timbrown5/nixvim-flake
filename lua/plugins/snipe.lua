local ok, snipe = pcall(require, "snipe")
if not ok then
	vim.notify("Snipe plugin not loaded", vim.log.levels.ERROR)
	return
end

snipe.setup({
	highlight_group = "IncSearch",
	label_keys = "fjdksla;ghvnmcbwoeirutyqpzxcvb",
	bounds = 150,
})

vim.keymap.set("n", "<leader>vs", function()
	snipe.open_buffer_menu()
end, { desc = "View buffer switcher" })
