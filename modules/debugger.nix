{
  config,
  pkgs,
  lib,
  ...
}: {
  # Debug setup with latest API
  plugins.dap = {
    enable = true;
  };
  
  # DAP UI and extensions with updated API paths
  plugins.dap-python.enable = true;
  plugins.dap-ui = {
    enable = true;
    settings = {
      controls = {
        enabled = true;
        element = "repl";
      };
      floating = {
        mappings = {
          close = ["<Esc>" "q"];
        };
      };
    };
  };
  plugins.dap-virtual-text.enable = true;
  
  # Set up debug configurations in Lua to avoid escaping issues
  extraConfigLua = ''
    -- Set up adapters in Lua
    local dap = require('dap')
    
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
  '';
  
  # Add development tools to system packages
  extraPackages = [
    pkgs.lldb
    pkgs.gcc
    pkgs.gnumake
  ];
}
