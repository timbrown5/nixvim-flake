-- Clipboard and register keybindings
local map = vim.keymap.set

-- QUICK REFERENCE:
-- Delete without yank: <leader>d
-- Paste from yank register: <leader>p

-- Better paste that checks if buffer is modifiable
local function safe_paste(cmd)
	return function()
		if vim.bo.modifiable then
			vim.cmd(cmd)
		else
			vim.notify("Cannot paste: buffer is not modifiable", vim.log.levels.WARN)
		end
	end
end

-- Better paste
map('v', 'p', function()
	if vim.bo.modifiable then
		vim.cmd([["_dP]])
	else
		vim.notify("Cannot paste: buffer is not modifiable", vim.log.levels.WARN)
	end
end, { desc = 'Paste without yanking' })

-- Delete without yanking (black hole register)
map('n', '<leader>d', '"_d', { desc = 'Delete without yanking' })
map('v', '<leader>d', '"_d', { desc = 'Delete without yanking' })
map('n', '<leader>D', '"_D', { desc = 'Delete to end of line without yanking' })
map('n', 'x', '"_x', { desc = 'Delete char without yanking' })

-- Paste from 0 register (last yank) with safety check
map('n', '<leader>p', safe_paste('"0p'), { desc = 'Paste from yank register' })
map('n', '<leader>P', safe_paste('"0P'), { desc = 'Paste from yank register before cursor' })
map('v', '<leader>p', safe_paste('"0p'), { desc = 'Paste from yank register' })

-- System clipboard operations
map('n', '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
map('v', '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
map('n', '<leader>Y', '"+Y', { desc = 'Yank line to system clipboard' })

-- Regular paste with safety check
map('n', 'p', safe_paste('normal! p'), { desc = 'Paste after cursor (safe)' })
map('n', 'P', safe_paste('normal! P'), { desc = 'Paste before cursor (safe)' })
