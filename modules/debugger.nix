{
  config,
  pkgs,
  lib,
  ...
}: {
  config = {
    # Debug setup - load on demand
    plugins.dap = {
      enable = true;
    };
    
    # DAP plugins - will be lazy loaded
    plugins.dap-python.enable = true;
    plugins.dap-ui = {
      enable = true;
      settings = {
        floating = {
          mappings = {
            close = ["<Esc>" "q"];
          };
        };
        controls = {
          enabled = true;
          element = "repl";
        };
      };
    };
    plugins.dap-virtual-text.enable = true;
    
    # Lazy load debug configurations
    extraConfigLua = ''
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
          command = '${pkgs.lldb}/bin/lldb-vscode', 
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
      
      -- Simplified DAP command wrappers
      local dap_commands = {
        ['DapToggleBreakpoint'] = 'toggle_breakpoint',
        ['DapContinue'] = 'continue',
        ['DapStepOver'] = 'step_over',
        ['DapStepInto'] = 'step_into',
        ['DapStepOut'] = 'step_out',
        ['DapTerminate'] = 'terminate',
      }
      
      for cmd, func_name in pairs(dap_commands) do
        vim.api.nvim_create_user_command(cmd, function()
          if ensure_dap_setup() then
            local dap = require('dap')
            dap[func_name]()
          end
        end, {})
      end
    '';
    
    # Add development tools - these are external packages, not loaded at startup
    extraPackages = [
      pkgs.lldb
      pkgs.gcc
      pkgs.gnumake
    ];
  };
}
