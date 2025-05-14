{
  config,
  pkgs,
  lib,
  ...
}: {
  config = {
    # Core keybindings
    globals.mapleader = " ";
    globals.maplocalleader = "\\";
    
    # Import keymaps Lua configuration
    extraConfigLua = builtins.readFile ../lua/keymaps.lua;
    
    # Which-key plugin configuration
    plugins.which-key = {
      enable = true;
      settings = {
        preset = "modern";
        delay = 0;
        layout = {
          width = { min = 20; };
          spacing = 3;
        };
        keys = {
          scroll_down = "<c-d>";
          scroll_up = "<c-u>";
        };
        win = {
          border = "single";
          padding = [ 1 2 ];
        };
      };
    };
  };
}
