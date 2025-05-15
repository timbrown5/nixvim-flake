-- Load all keybindings
local ok, keybinds = pcall(require, 'keybinds')
if not ok then
	vim.notify("Unable to load keybinds module", vim.log.levels.WARN)
end

-- Register which-key groups (summary)
local wk_ok, wk = pcall(require, 'which-key')
if wk_ok then
	wk.add({
		{ '<leader>',  group = 'Leader' },
		{ '<leader>s', group = 'Split' },
	})
end
