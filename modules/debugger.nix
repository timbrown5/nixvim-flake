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
    
    # Set LLDB path for the Lua config
    extraConfigLuaPre = ''
      vim.g.lldb_vscode_path = '${pkgs.lldb}/bin/lldb-vscode'
    '';
    
    # Import debugger configuration from Lua file
    extraConfigLua = builtins.readFile ../lua/debugger.lua;
    
    # Add development tools - these are external packages, not loaded at startup
    extraPackages = [
      pkgs.lldb
      pkgs.gcc
      pkgs.gnumake
    ];
  };
}
