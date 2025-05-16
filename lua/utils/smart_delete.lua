_G.smart_delete = function(type)
	if not type then
		return function()
			if vim.fn.col('.') == 1 then
				if vim.fn.line('.') ~= 1 then
					return '"_d0"'
				else
					return '"_d"'
				end
			else
				return '"_d^'
			end
		end
	else
		vim.cmd('normal! "_dd')
	end
end
