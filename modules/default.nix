{ pkgs, lib, ... }:
{
  imports = [
    ./nvchad.nix
    ./options.nix
    ./core-plugins.nix
    ./snacks.nix
    ./mini.nix
    ./precognition.nix
    ./conform.nix
  ];

  config = {
    nvchad.enable = true;
    customPlugins.snacks.enable = true;

    viAlias = true;
    vimAlias = true;

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
        wl-copy.enable = true;
        xclip.enable = true;
      };
    };

    extraPackages = with pkgs; [
      nodejs
      gcc

      lua-language-server

      nixd

      python313
      python313Packages.pip
      python313Packages.debugpy
      pyright

      nodePackages.typescript-language-server
    ];

    extraFiles = {
      "lua/config/nvchad-config.lua".source = ../lua/config/nvchad-config.lua;
      "lua/config/user-config.lua".source = ../lua/config/user-config.lua;
      "lua/config/fallback.lua".source = ../lua/config/fallback.lua;
      "lua/config/health-check.lua".source = ../lua/config/health-check.lua;
      "lua/plugins/snipe.lua".source = ../lua/plugins/snipe.lua;

      # Health check integration for :checkhealth
      "lua/health/nixvim.lua".text = ''
        return require('config.health-check')
      '';
    };

    extraConfigLua = ''
      vim.opt.clipboard = "unnamedplus"

      require('config.nvchad-config')
      require('config.fallback')
      require('config.user-config')

      require('plugins.snipe')
    '';
  };
}
