-- Defer keymaps that depend on functions
vim.defer_fn(function()
  local function safe_keymap(mode, key, action, opts)
    local ok, error = pcall(vim.keymap.set, mode, key, action, opts)
    if not ok then
      vim.notify("Failed to set keymap " .. key .. ": " .. tostring(error), vim.log.levels.ERROR)
    end
  end

  -- Smart delete keymaps
  safe_keymap('n', '<leader>d', function()
    if _G.smart_delete then
      return _G.smart_delete()
    else
      return ""
    end
  end, { expr = true, desc = "Delete without copying" })

  safe_keymap('n', '<leader>dd', function()
    if _G.smart_delete then
      _G.smart_delete('line')
    end
  end, { desc = "Delete line without copying" })

  safe_keymap('v', '<leader>d', '"_d', { desc = "Delete selection without copying" })
end, 100)

-- DAP keymaps - only set up when DAP is loaded
vim.api.nvim_create_autocmd("User", {
  pattern = "DapReady",
  once = true,
  callback = function()
    local function safe_keymap(mode, key, action, opts)
      local ok, error = pcall(vim.keymap.set, mode, key, action, opts)
      if not ok then
        vim.notify("Failed to set keymap " .. key .. ": " .. tostring(error),
          vim.log.levels.ERROR)
      end
    end

    safe_keymap('n', '<leader>Db', function()
      local ok, dap = pcall(require, 'dap')
      if ok then
        dap.toggle_breakpoint()
      end
    end, { desc = "Toggle breakpoint" })

    safe_keymap('n', '<leader>Dc', function()
      local ok, dap = pcall(require, 'dap')
      if ok then
        dap.continue()
      end
    end, { desc = "Start/Continue debugging" })

    safe_keymap('n', '<leader>Dj', function()
      local ok, dap = pcall(require, 'dap')
      if ok then
        dap.step_over()
      end
    end, { desc = "Step over" })

    safe_keymap('n', '<leader>Du', function()
      local ok, dapui = pcall(require, 'dapui')
      if ok then
        dapui.toggle()
      end
    end, { desc = "Toggle DAP UI" })
  end
})
