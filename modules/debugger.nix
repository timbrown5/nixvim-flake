{
  config,
  pkgs,
  lib,
  ...
}: {
  # Debug setup with latest API
  plugins.dap = {
    enable = true;
    
    adapters = {
      python = {
        type = "executable";
        command = "python";
        args = ["-m" "debugpy.adapter"];
      };
      
      cppdbg = {
        type = "executable";
        command = "${pkgs.vscode-extensions.ms-vscode.cpptools}/share/vscode/extensions/ms-vscode.cpptools/debugAdapters/bin/OpenDebugAD7";
        name = "cppdbg";
      };
    };
  };
  
  # DAP UI and extensions with latest API
  plugins.dap.extensions = {
    dap-python.enable = true;
    dap-ui = {
      enable = true;
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
    dap-virtual-text.enable = true;
  };
  
  # Set up debug configurations in Lua to avoid escaping issues
  extraConfigLua = ''
    -- Python configurations
    require('dap').configurations.python = {
      {
        type = 'python',
        request = 'launch',
        name = 'Launch file',
        program = ''${file},
        pythonPath = 'python',
      }
    }
    
    -- C/C++ configurations
    require('dap').configurations.cpp = {
      {
        name = "Launch",
        type = "cppdbg",
        request = "launch",
        program = ''${workspaceFolder}/build/''${fileBasenameNoExtension},
        args = {},
        stopAtEntry = true,
        cwd = ''${workspaceFolder},
        MIMode = "gdb",
        miDebuggerPath = "${pkgs.gdb}/bin/gdb",
      }
    }
    require('dap').configurations.c = require('dap').configurations.cpp
  '';
}
