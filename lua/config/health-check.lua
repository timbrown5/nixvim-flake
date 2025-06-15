local M = {}

local function run_health_checks()
	local issues = {}
	local successes = {}

	local critical_plugins = {
		{ name = "snacks", desc = "File explorer & utilities" },
		{ name = "conform", desc = "Code formatting" },
		{ name = "catppuccin", desc = "Color scheme" },
		{ name = "which-key", desc = "Keybinding help" },
		{ name = "blink-cmp", desc = "Completion engine" },
	}

	for _, plugin in ipairs(critical_plugins) do
		local ok, _ = pcall(require, plugin.name)
		if not ok then
			table.insert(issues, { type = "plugin", name = plugin.name, desc = plugin.desc })
		else
			table.insert(successes, { type = "plugin", name = plugin.name, desc = plugin.desc })
		end
	end

	local formatters = {
		{ cmd = "stylua", desc = "Lua formatter" },
		{ cmd = "nixfmt", desc = "Nix formatter" },
		{ cmd = "prettier", desc = "JS/TS/JSON/etc formatter" },
		{ cmd = "black", desc = "Python formatter" },
	}

	for _, formatter in ipairs(formatters) do
		if vim.fn.executable(formatter.cmd) == 0 then
			table.insert(issues, { type = "formatter", name = formatter.cmd, desc = formatter.desc })
		else
			table.insert(successes, { type = "formatter", name = formatter.cmd, desc = formatter.desc })
		end
	end

	local active_clients = vim.lsp.get_active_clients()
	if #active_clients == 0 then
		table.insert(issues, { type = "lsp", name = "LSP clients", desc = "No active clients" })
	else
		table.insert(successes, { type = "lsp", name = "LSP clients", desc = #active_clients .. " active" })
	end

	local dap_ok, dap = pcall(require, "dap")
	if dap_ok and dap.configurations.python then
		table.insert(successes, { type = "debug", name = "Python debugging", desc = "configured" })
	else
		table.insert(issues, { type = "debug", name = "Python debugging", desc = "not configured" })
	end

	return successes, issues
end

function M.check_config_health()
	local successes, issues = run_health_checks()

	local results = {}
	if #successes > 0 then
		table.insert(results, "✅ WORKING:")
		for _, success in ipairs(successes) do
			table.insert(results, "  ✅ " .. success.name .. " (" .. success.desc .. ")")
		end
	end

	if #issues > 0 then
		table.insert(results, "\n⚠️  ISSUES:")
		for _, issue in ipairs(issues) do
			table.insert(results, "  ❌ " .. issue.name .. " (" .. issue.desc .. ")")
		end
	end

	if #issues == 0 then
		table.insert(results, "\n🎉 All systems operational!")
	end

	vim.notify(table.concat(results, "\n"), vim.log.levels.INFO)
end

-- Health check integration for :checkhealth
function M.check()
	local health = vim.health or require("health")

	health.start("NixVim Configuration")

	local successes, issues = run_health_checks()

	for _, success in ipairs(successes) do
		health.ok(success.name .. " (" .. success.desc .. ")")
	end

	for _, issue in ipairs(issues) do
		if issue.type == "formatter" then
			health.warn(issue.name .. " (" .. issue.desc .. ") not found in PATH")
		else
			health.error(issue.name .. " (" .. issue.desc .. ") failed to load")
		end
	end

	local total_checks = #successes + #issues
	local success_rate = math.floor((#successes / total_checks) * 100)

	if #issues == 0 then
		health.ok(string.format("All %d checks passed! 🎉", total_checks))
	else
		health.info(string.format("Summary: %d/%d checks passed (%d%%)", #successes, total_checks, success_rate))
	end
end

return M
