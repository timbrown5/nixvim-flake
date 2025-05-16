-- This file exists because the NixVim module for Snacks.nvim doesn't support
-- the keymaps configuration option. While all other Snacks configuration
-- is handled through the declarative NixVim interface, keybindings need
-- to be set up separately in Lua.

-- Use the VimEnter event to set up keybindings after all plugins are loaded
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		-- Check if Snacks is available
		local ok, Snacks = pcall(require, "snacks")
		if not ok then
			vim.notify("Snacks plugin not found - keybindings skipped", vim.log.levels.WARN)
			return
		end

		-- Set up keybindings for Snacks
		-- File explorer
		vim.keymap.set("n", "<C-n>", "<cmd>Snacks explorer<CR>", { desc = "Toggle file explorer" })

		-- Picker (fuzzy finding)
		vim.keymap.set("n", "<leader>ff", "<cmd>Snacks picker.files<CR>", { desc = "Find files" })
		vim.keymap.set("n", "<leader>fw", "<cmd>Snacks picker.grep<CR>", { desc = "Live grep" })
		vim.keymap.set("n", "<leader>fb", "<cmd>Snacks picker.buffers<CR>", { desc = "Find buffers" })
		vim.keymap.set("n", "<leader>fh", "<cmd>Snacks picker.help<CR>", { desc = "Find help" })
		vim.keymap.set("n", "<leader>fr", "<cmd>Snacks picker.recent_files<CR>", { desc = "Recent files" })
		vim.keymap.set("n", "<leader>fd", "<cmd>Snacks picker.diagnostics<CR>", { desc = "Diagnostics" })
		vim.keymap.set("n", "<leader>fs", "<cmd>Snacks picker.symbols<CR>", { desc = "Symbols" })
		vim.keymap.set("n", "<leader>fc", "<cmd>Snacks picker.commands<CR>", { desc = "Commands" })
		vim.keymap.set("n", "<leader>fk", "<cmd>Snacks picker.keymaps<CR>", { desc = "Keymaps" })

		-- Git operations
		vim.keymap.set("n", "<leader>gc", "<cmd>Snacks picker.git_commits<CR>", { desc = "Git commits" })
		vim.keymap.set("n", "<leader>gb", "<cmd>Snacks picker.git_branches<CR>", { desc = "Git branches" })
		vim.keymap.set("n", "<leader>gs", "<cmd>Snacks picker.git_status<CR>", { desc = "Git status" })

		-- Notifications
		vim.keymap.set("n", "<leader>sn", "<cmd>Snacks notifier.show_history<CR>",
			{ desc = "Show notification history" })
		vim.keymap.set("n", "<leader>sd", "<cmd>Snacks notifier.dismiss<CR>", { desc = "Dismiss notifications" })
		vim.keymap.set("n", "<leader>st",
			function() Snacks.notifier.notify('This is a test notification', 'info') end,
			{ desc = "Test notification" })

		-- Image preview
		vim.keymap.set("n", "<leader>si", "<cmd>Snacks image.show_current_file<CR>",
			{ desc = "Show image preview" })
		vim.keymap.set("n", "<leader>sc", "<cmd>Snacks image.show_clipboard<CR>",
			{ desc = "Show clipboard image" })

		-- Terminal additional keybindings
		-- Note: The main toggle keybinding (<leader>tt) is set in the Nix config,
		-- but we can add additional keybindings here, like terminal navigation keys
		vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Terminal normal mode" })
		vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Terminal navigate left" })
		vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Terminal navigate down" })
		vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Terminal navigate up" })
		vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Terminal navigate right" })

		-- LSP-related Snacks picker integrations
		-- Traditional Vim-style navigation using Snacks picker
		vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Go to definition" })
		vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end, { desc = "Go to references" })
		vim.keymap.set("n", "gi", function() Snacks.picker.lsp_implementations() end,
			{ desc = "Go to implementation" })
		vim.keymap.set("n", "gt", function() Snacks.picker.lsp_type_definitions() end,
			{ desc = "Go to type definition" })

		-- Namespaced LSP navigation using Snacks picker
		vim.keymap.set("n", "<leader>ld", function() Snacks.picker.lsp_definitions() end,
			{ desc = "LSP: Go to definition" })
		vim.keymap.set("n", "<leader>lr", function() Snacks.picker.lsp_references() end,
			{ desc = "LSP: Go to references" })
		vim.keymap.set("n", "<leader>li", function() Snacks.picker.lsp_implementations() end,
			{ desc = "LSP: Go to implementation" })
		vim.keymap.set("n", "<leader>lt", function() Snacks.picker.lsp_type_definitions() end,
			{ desc = "LSP: Go to type definition" })

		-- Diagnostics with Snacks
		vim.keymap.set("n", "<leader>dl", function() Snacks.picker.diagnostics() end,
			{ desc = "Diagnostics: List" })

		-- Register the keymaps with which-key if it's available
		local wk_ok, wk = pcall(require, "which-key")
		if wk_ok then
			wk.register({
				["<leader>f"] = { name = "Find" },
				["<leader>g"] = { name = "Git" },
				["<leader>s"] = { name = "Split & Snacks" },
				["<leader>t"] = { name = "Terminal & Tabs" },
				["<leader>l"] = { name = "LSP" },
				["<leader>d"] = { name = "Diagnostics" },
				["<leader>b"] = { name = "Buffer" },
				["<leader>m"] = { name = "Mini" },
				["<leader>z"] = { name = "Fold" },
			})
		end

		vim.notify("Snacks keybindings loaded", vim.log.levels.INFO)
	end,
	once = true, -- Only run this once
})
