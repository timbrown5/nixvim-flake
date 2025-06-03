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

-- Snipe keybind
vim.keymap.set('n', '<leader>S', function()
  snipe.open_buffer_menu()
end, { desc = "Open Snipe buffer menu" })
