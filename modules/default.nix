{ pkgs, lib, ... }:
{
  imports = [
    ./nvchad.nix
    ./options.nix
    ./core-plugins.nix
    ./snacks.nix
    ./mini.nix
    ./precognition.nix
    # ./dashboard.nix removed - now using Snacks dashboard
  ];

  config = {
    nvchad.enable = true;
    customPlugins.snacks.enable = true;

    viAlias = true;
    vimAlias = true;

    # Performance optimizations
    performance = {
      byteCompileLua = {
        enable = true;
        nvimRuntime = true;
        configs = true;
        plugins = true;
      };
    };

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

      # Lua ecosystem
      lua-language-server # Lua LSP

      # Nix ecosystem
      nixd # Nix LSP

      # Python ecosystem
      python313
      python313Packages.pip
      python313Packages.debugpy # Python debugger
      pyright # Python LSP

      # TypeScript/JavaScript ecosystem
      nodePackages.typescript-language-server # TypeScript LSP
    ];

    extraFiles = {
      "lua/config/nvchad-config.lua".source = ../lua/config/nvchad-config.lua;
      "lua/config/user-config.lua".source = ../lua/config/user-config.lua;
      "lua/config/fallback.lua".source = ../lua/config/fallback.lua;
      "lua/plugins/snipe.lua".source = ../lua/plugins/snipe.lua;
    };

    extraConfigLua = ''
      vim.opt.runtimepath:prepend(vim.fn.stdpath("config"))

      -- Ensure system clipboard integration
      vim.opt.clipboard = "unnamedplus"

      require('config.nvchad-config')
      require('config.fallback')
      require('config.user-config')

      require('plugins.snipe')
    '';
  };
}
