{
  config,
  pkgs,
  lib,
  ...
}: {
  config = {
    # Debug setup with latest API
    plugins.dap = {
      enable = true;
    };
    
    # DAP plugins - moved out of extensions
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
    
    # Set up debug configurations in Lua to avoid escaping issues
    extraConfigLua = ''
      -- Error handling wrapper
      local function safe_dap_setup()
        local ok, dap = pcall(require, 'dap')
        if not ok then
          vim.notify("Failed to load DAP: " .. tostring(dap), vim.log.levels.ERROR)
          return
        end
        
        -- Python adapter
        dap.adapters.python = {
          type = 'executable',
          command = 'python',
          args = {'-m', 'debugpy.adapter'}
        }
        
        -- Use LLDB adapter instead of cppdbg
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
            program = vim.fn.expand('%:p'),  -- Full path to current file
            pythonPath = 'python',
          }
        }
        
        -- C/C++ configurations using LLDB
        dap.configurations.cpp = {
          {
            name = "Launch",
            type = "lldb",
            request = "launch",
            program = function()
              return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/build/', 'file')
            end,
            cwd = vim.fn.getcwd(),  -- Current working directory
            stopOnEntry = false,
            args = {},
            runInTerminal = false,
          }
        }
        dap.configurations.c = dap.configurations.cpp
      end
      
      -- Set up DAP with error handling
      safe_dap_setup()
    '';
    
    # Add development tools to system packages
    extraPackages = [
      pkgs.lldb
      pkgs.gcc
      pkgs.gnumake
    ];
  };
}
