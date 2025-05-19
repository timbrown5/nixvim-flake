{ pkgs, lib, ... }:
{
  imports = [
    ./nvchad.nix
    ./options.nix
    ./core-plugins.nix
    ./snacks.nix
    ./mini.nix
    ./precognition.nix
  ];

  config = {
    nvchad.enable = true;
    customPlugins.snacks.enable = true;

    viAlias = true;
    vimAlias = true;

    clipboard = {
      register = "unnamedplus";
      providers = {
        wl-copy.enable = true; # For Wayland systems
        xclip.enable = true; # For X11 systems
      };
    };

    extraPackages = with pkgs; [
      # Core development tools
      nodejs
      gcc

      # Python 3.13 with pip
      python313
      python313Packages.pip

      # Language servers
      lua-language-server
      nil
      nodePackages.typescript-language-server
      pyright
    ];

    extraFiles = {
      "lua/config/nvchad-config.lua".source = ../lua/config/nvchad-config.lua;
      "lua/config/user-config.lua".source = ../lua/config/user-config.lua;
      "lua/config/fallback.lua".source = ../lua/config/fallback.lua;
      "lua/plugins/snipe.lua".source = ../lua/plugins/snipe.lua;
      "lua/keybinds/deferred.lua".source = ../lua/keybinds/deferred.lua;
      "lua/keybinds/init.lua".source = ../lua/keybinds/init.lua;
      "lua/utils/smart_delete.lua".source = ../lua/utils/smart_delete.lua;
    };

    extraConfigLua = ''
      vim.opt.runtimepath:prepend(vim.fn.stdpath("config"))

      -- Ensure system clipboard integration
      vim.opt.clipboard = "unnamedplus"

      require('config.nvchad-config')
      require('config.fallback')
      require('config.user-config')

      require('utils.smart_delete')
      require('keybinds').setup()
      require('plugins.snipe')
      require('keybinds.deferred')
    '';
  };
}
