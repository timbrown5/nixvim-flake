{ pkgs, lib, ... }: {
  imports = [
    ./nvchad.nix
    ./options.nix
  ];

  config = {
    viAlias = true;
    vimAlias = true;

    clipboard = {
      register = "unnamedplus";
      providers = {
        wl-copy.enable = true;
        xclip.enable = true;
      };
    };

    extraPackages = with pkgs; [
      ripgrep
      fd
      nodejs
      gcc
      
      lua-language-server
      nil
      nodePackages.typescript-language-server
      pyright
      
      imagemagick
      ghostscript
      tectonic
      mermaid-cli
    ];
    
    extraFiles = {
      "lua/config/nvchad-config.lua".source = ../lua/config/nvchad-config.lua;
      "lua/config/user-config.lua".source = ../lua/config/user-config.lua;
      "lua/config/fallback.lua".source = ../lua/config/fallback.lua;
      "lua/plugins/snacks-keybinds.lua".source = ../lua/plugins/snacks-keybinds.lua;
      "lua/plugins/snipe.lua".source = ../lua/plugins/snipe.lua;
      "lua/keybinds/deferred.lua".source = ../lua/keybinds/deferred.lua;
      "lua/utils/smart_delete.lua".source = ../lua/utils/smart_delete.lua;
    };
    
    extraConfigLua = ''
      vim.opt.runtimepath:prepend(vim.fn.stdpath("config"))
      
      require('config.nvchad-config')
      require('config.fallback')
      require('config.user-config')
      
      require('utils.smart_delete')
      require('plugins.snacks-keybinds')
      require('plugins.snipe')
      require('keybinds.deferred')
    '';
  };
}
