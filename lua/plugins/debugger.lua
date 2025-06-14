vim.fn.sign_define("DapBreakpoint", {
	text = "🔴",
	texthl = "DapBreakpoint",
	linehl = "",
	numhl = "",
})

vim.fn.sign_define("DapBreakpointCondition", {
	text = "🟡",
	texthl = "DapBreakpointCondition",
	linehl = "",
	numhl = "",
})

vim.fn.sign_define("DapLogPoint", {
	text = "📝",
	texthl = "DapLogPoint",
	linehl = "",
	numhl = "",
})

vim.fn.sign_define("DapStopped", {
	text = "➡️",
	texthl = "DapStopped",
	linehl = "DapStoppedLine",
	numhl = "",
})

local function safe_keymap(mode, key, action, opts)
	local ok, error = pcall(vim.keymap.set, mode, key, action, opts)
	if not ok then
		vim.notify("Failed to set keymap " .. key .. ": " .. tostring(error), vim.log.levels.ERROR)
	end
end

local dap_ok, dap = pcall(require, "dap")
if dap_ok then
	dap.adapters.python = function(cb, config)
		if config.request == "attach" then
			local port = (config.connect or config).port
			local host = (config.connect or config).host or "127.0.0.1"
			cb({
				type = "server",
				port = assert(port, "`connect.port` is required for a python `attach` configuration"),
				host = host,
				options = {
					source_filetype = "python",
				},
			})
		else
			cb({
				type = "executable",
				command = vim.fn.exepath("python3") or vim.fn.exepath("python") or "python3",
				args = { "-m", "debugpy.adapter" },
				options = {
					source_filetype = "python",
				},
			})
		end
	end

	dap.configurations.python = {
		{
			type = "python",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			pythonPath = function()
				return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python3"
			end,
		},
		{
			type = "python",
			request = "launch",
			name = "Launch file with arguments",
			program = "${file}",
			args = function()
				local args_string = vim.fn.input("Arguments: ")
				return vim.split(args_string, " +")
			end,
			pythonPath = function()
				return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python3"
			end,
		},
	}

	local dapui_ok, dapui = pcall(require, "dapui")
	if dapui_ok then
		dapui.setup()

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end
	end

	local virtual_text_ok, virtual_text = pcall(require, "nvim-dap-virtual-text")
	if virtual_text_ok then
		virtual_text.setup()
	end
end

vim.api.nvim_create_autocmd("User", {
	pattern = "DapReady",
	once = true,
	callback = function()
		safe_keymap("n", "<leader>Db", function()
			local ok, dap = pcall(require, "dap")
			if ok then
				dap.toggle_breakpoint()
			else
				vim.notify("DAP not available", vim.log.levels.WARN)
			end
		end, { desc = "Toggle breakpoint" })

		safe_keymap("n", "<leader>Dc", function()
			local ok, dap = pcall(require, "dap")
			if ok then
				dap.continue()
			else
				vim.notify("DAP not available", vim.log.levels.WARN)
			end
		end, { desc = "Start/Continue debugging" })

		safe_keymap("n", "<leader>Dj", function()
			local ok, dap = pcall(require, "dap")
			if ok then
				dap.step_over()
			else
				vim.notify("DAP not available", vim.log.levels.WARN)
			end
		end, { desc = "Step over" })

		safe_keymap("n", "<leader>Di", function()
			local ok, dap = pcall(require, "dap")
			if ok then
				dap.step_into()
			else
				vim.notify("DAP not available", vim.log.levels.WARN)
			end
		end, { desc = "Step into" })

		safe_keymap("n", "<leader>Do", function()
			local ok, dap = pcall(require, "dap")
			if ok then
				dap.step_out()
			else
				vim.notify("DAP not available", vim.log.levels.WARN)
			end
		end, { desc = "Step out" })

		safe_keymap("n", "<leader>Dr", function()
			local ok, dap = pcall(require, "dap")
			if ok then
				dap.restart()
			else
				vim.notify("DAP not available", vim.log.levels.WARN)
			end
		end, { desc = "Restart debugging" })

		safe_keymap("n", "<leader>Dt", function()
			local ok, dap = pcall(require, "dap")
			if ok then
				dap.terminate()
			else
				vim.notify("DAP not available", vim.log.levels.WARN)
			end
		end, { desc = "Terminate debugging" })

		safe_keymap("n", "<leader>Du", function()
			local ok, dapui = pcall(require, "dapui")
			if ok then
				dapui.toggle()
			else
				vim.notify("DAP UI not available", vim.log.levels.WARN)
			end
		end, { desc = "Toggle DAP UI" })

		safe_keymap("n", "<leader>De", function()
			local ok, dapui = pcall(require, "dapui")
			if ok then
				dapui.eval()
			else
				vim.notify("DAP UI not available", vim.log.levels.WARN)
			end
		end, { desc = "Evaluate expression" })

		safe_keymap("v", "<leader>De", function()
			local ok, dapui = pcall(require, "dapui")
			if ok then
				dapui.eval()
			else
				vim.notify("DAP UI not available", vim.log.levels.WARN)
			end
		end, { desc = "Evaluate selection" })

		vim.notify("DAP keymaps loaded", vim.log.levels.INFO)
	end,
})

safe_keymap("n", "<leader>DB", function()
	local ok, dap = pcall(require, "dap")
	if ok then
		dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
	else
		vim.notify("DAP not available", vim.log.levels.WARN)
	end
end, { desc = "Set conditional breakpoint" })

safe_keymap("n", "<leader>Dl", function()
	local ok, dap = pcall(require, "dap")
	if ok then
		dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
	else
		vim.notify("DAP not available", vim.log.levels.WARN)
	end
end, { desc = "Set log point" })
