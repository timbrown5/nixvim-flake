-- Don't set up DAP immediately - wait for first use
local dap_setup_done = false

local function ensure_dap_setup()
  if dap_setup_done then
    return true
  end
  
  local ok, dap = pcall(require, 'dap')
  if not ok then
    vim.notify("Failed to load DAP: " .. tostring(dap), vim.log.levels.ERROR)
    return false
  end
  
  -- Python adapter
  dap.adapters.python = {
    type = 'executable',
    command = 'python',
    args = {'-m', 'debugpy.adapter'}
  }
  
  -- LLDB adapter for C/C++
  dap.adapters.lldb = {
    type = 'executable',
    command = vim.g.lldb_vscode_path or 'lldb-vscode', 
    name = 'lldb'
  }
  
  -- Python configurations
  dap.configurations.python = {
    {
      type = 'python',
      request = 'launch',
      name = 'Launch file',
      program = vim.fn.expand('%:p'),
      pythonPath = 'python',
    }
  }
  
  -- C/C++ configurations
  dap.configurations.cpp = {
    {
      name = "Launch",
      type = "lldb",
      request = "launch",
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/build/', 'file')
      end,
      cwd = vim.fn.getcwd(),
      stopOnEntry = false,
      args = {},
      runInTerminal = false,
    }
  }
  dap.configurations.c = dap.configurations.cpp
  
  dap_setup_done = true
  return true
end

-- Create commands that set up DAP on first use
vim.api.nvim_create_user_command('DapSetup', ensure_dap_setup, {})

-- DAP keymaps
local function setup_dap_keymaps()
  if not ensure_dap_setup() then
    return
  end
  
  local function map(key, action, desc)
    vim.keymap.set('n', key, action, { desc = desc })
  end
  
  local dap = require('dap')
  local dapui = require('dapui')
  
  -- LazyVim style DAP keymaps
  map('<F5>', dap.continue, "Continue")
  map('<F10>', dap.step_over, "Step Over")
  map('<F11>', dap.step_into, "Step Into")
  map('<F12>', dap.step_out, "Step Out")
  
  map('<leader>db', dap.toggle_breakpoint, "Toggle Breakpoint")
  map('<leader>dB', function() dap.set_breakpoint(vim.fn.input('[Condition] > ')) end, "Conditional Breakpoint")
  map('<leader>dc', dap.continue, "Continue")
  map('<leader>dC', function() dap.run_to_cursor() end, "Run to Cursor")
  map('<leader>dg', function() dap.goto_() end, "Go to line (no execute)")
  map('<leader>di', function() dap.step_into() end, "Step Into")
  map('<leader>dj', function() dap.down() end, "Down")
  map('<leader>dk', function() dap.up() end, "Up")
  map('<leader>dl', function() dap.run_last() end, "Run Last")
  map('<leader>do', function() dap.step_out() end, "Step Out")
  map('<leader>dO', function() dap.step_over() end, "Step Over")
  map('<leader>dp', function() dap.pause() end, "Pause")
  map('<leader>dr', function() dap.repl.toggle() end, "Toggle REPL")
  map('<leader>ds', function() dap.session() end, "Session")
  map('<leader>dt', function() dap.terminate() end, "Terminate")
  map('<leader>dw', function() require('dap.ui.widgets').hover() end, "Widgets")
  
  map('<leader>du', function() dapui.toggle() end, "Dap UI")
  map('<leader>de', function() dapui.eval() end, "Eval")
  
  -- Visual mode
  vim.keymap.set('v', '<leader>de', function() dapui.eval() end, { desc = "Eval" })
  
  -- Register which-key groups
  local ok, wk = pcall(require, "which-key")
  if ok then
    wk.add({
      { "<leader>d", group = "debug" },
    })
  end
end

-- Set up keymaps when DAP is loaded
vim.api.nvim_create_autocmd("User", {
  pattern = "DapLoaded",
  once = true,
  callback = setup_dap_keymaps
})

-- Also set up keymaps if DAP is already loaded
if package.loaded['dap'] then
  setup_dap_keymaps()
end
