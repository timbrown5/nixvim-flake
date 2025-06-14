local M = {}

-- Helper function for safe keymapping
local function safe_keymap(mode, key, action, opts)
	local ok, error = pcall(vim.keymap.set, mode, key, action, opts)
	if not ok then
		vim.notify("Failed to set keymap " .. key .. ": " .. tostring(error), vim.log.levels.ERROR)
	end
end

-- Toggle auto-format on save with user feedback
function M.toggle_autoformat()
	vim.g.disable_autoformat = not vim.g.disable_autoformat
	local status = vim.g.disable_autoformat and "DISABLED" or "ENABLED"
	vim.notify("Auto-format: " .. status, vim.log.levels.INFO)
end

-- Format with specific formatter (with error handling)
function M.format_with(formatter_name)
	local ok, conform = pcall(require, "conform")
	if not ok then
		vim.notify("Conform not available", vim.log.levels.ERROR)
		return
	end

	conform.format({
		formatters = { formatter_name },
		async = true,
	})
end

-- Format with fallback to LSP
function M.format_smart()
	local ok, conform = pcall(require, "conform")
	if not ok then
		vim.notify("Conform not available, falling back to LSP", vim.log.levels.WARN)
		vim.lsp.buf.format()
		return
	end

	conform.format({
		async = true,
		lsp_fallback = true,
	})
end

-- Format imports (Python with Ruff)
function M.format_imports()
	local ok, conform = pcall(require, "conform")
	if not ok then
		vim.notify("Conform not available", vim.log.levels.ERROR)
		return
	end

	conform.format({
		formatters = { "ruff_organize_imports" },
		async = true,
	})
end

-- Set up all keybindings
function M.setup_keybindings()
	-- Main formatting keybindings
	safe_keymap("n", "<leader>bf", M.format_smart, { desc = "Buffer format (entire file with conform)" })
	safe_keymap("n", "<leader>ff", M.format_smart, { desc = "Format motion (e.g. <leader>ffap for paragraph)" })
	safe_keymap("v", "<leader>ff", M.format_smart, { desc = "Format visual selection" })

	-- Utility keybindings
	safe_keymap("n", "<leader>ft", M.toggle_autoformat, { desc = "Toggle auto-format on save" })
	safe_keymap("n", "<leader>fi", "<cmd>ConformInfo<cr>", { desc = "Show formatter info" })

	-- Specific formatter keybindings (uppercase = specific tool)
	safe_keymap("n", "<leader>fR", function()
		M.format_with("ruff_format")
	end, { desc = "Format with Ruff" })
	safe_keymap("n", "<leader>fB", function()
		M.format_with("black")
	end, { desc = "Format with Black" })
	safe_keymap("n", "<leader>fP", function()
		M.format_with("prettier")
	end, { desc = "Format with Prettier" })
	safe_keymap("n", "<leader>fJ", function()
		M.format_with("jq")
	end, { desc = "Format with jq" })
	safe_keymap("n", "<leader>fY", function()
		M.format_with("yq")
	end, { desc = "Format with yq" })
	safe_keymap("n", "<leader>fL", function()
		M.format_with("stylua")
	end, { desc = "Format with StyLua (Lua)" })
	safe_keymap("n", "<leader>fS", function()
		M.format_with("shfmt")
	end, { desc = "Format with shfmt (Shell)" })
	safe_keymap("n", "<leader>fN", function()
		M.format_with("nixfmt")
	end, { desc = "Format with nixfmt" })
	safe_keymap("n", "<leader>fG", function()
		M.format_with("gofmt")
	end, { desc = "Format with gofmt" })
	safe_keymap("n", "<leader>fI", function()
		M.format_with("goimports")
	end, { desc = "Format with goimports" })

	-- Import sorting
	safe_keymap("n", "<leader>oi", M.format_imports, { desc = "Order imports (Python - Ruff)" })
end

-- Set up auto-format behavior
function M.setup_autoformat()
	-- Disable auto-format for certain file patterns
	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = { "*.md", "*.txt" },
		callback = function()
			vim.b.disable_autoformat = true
		end,
	})

	-- Custom commands for formatting control
	vim.api.nvim_create_user_command("FormatDisable", function()
		vim.b.disable_autoformat = true
		vim.notify("Formatting disabled for this buffer", vim.log.levels.INFO)
	end, { desc = "Disable formatting for current buffer" })

	vim.api.nvim_create_user_command("FormatEnable", function()
		vim.b.disable_autoformat = false
		vim.notify("Formatting enabled for this buffer", vim.log.levels.INFO)
	end, { desc = "Enable formatting for current buffer" })
end

-- Main setup function
function M.setup()
	M.setup_keybindings()
	M.setup_autoformat()

	vim.notify("Conform formatting setup complete", vim.log.levels.INFO)
end

-- Auto-setup when file is loaded
M.setup()

return M
