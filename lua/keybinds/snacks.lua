-- Snacks utilities keybindings (other than picker)
local map = vim.keymap.set

-- Snacks notifications
map('n', '<leader>sn', '<cmd>lua Snacks.notifier.show_history()<CR>', { desc = 'Show notification history' })
map('n', '<leader>sd', '<cmd>lua Snacks.notifier.dismiss()<CR>', { desc = 'Dismiss notifications' })
map('n', '<leader>st', '<cmd>lua Snacks.notifier.notify("This is a test notification", "info")<CR>',
	{ desc = 'Test notification' })

-- Snacks image
map('n', '<leader>si', '<cmd>lua Snacks.image.show_current_file()<CR>', { desc = 'Show image preview' })
map('n', '<leader>sc', '<cmd>lua Snacks.image.show_clipboard()<CR>', { desc = 'Show clipboard image' })

-- Register which-key group
local ok, wk = pcall(require, 'which-key')
if ok then
	wk.add({
		{ '<leader>s', group = 'Snacks/Split' },
	})
end
