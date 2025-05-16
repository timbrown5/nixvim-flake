{ pkgs, lib, ... }: {
  # Import submodules
  imports = [
    ./nvchad.nix
    ./core-plugins.nix
    ./options.nix
  ];

  # Basic settings
  config = {
    viAlias = true;
    vimAlias = true;

    # Add clipboard support
    clipboard = {
      register = "unnamedplus";
      providers = {
        wl-copy.enable = true;  # Wayland (Linux)
        xclip.enable = true;    # X11 (Linux)
      };
    };

    # Extra packages needed for functionality
    extraPackages = with pkgs; [
      # Required for various plugins
      ripgrep
      fd
      nodejs
      gcc
      
      # Language servers
      lua-language-server
      nil
      nodePackages.typescript-language-server
      pyright
      
      # Required for Snacks.image
      imagemagick    # provides magick/convert
      ghostscript    # provides gs
      tectonic       # LaTeX compiler
      mermaid-cli    # provides mmdc for Mermaid diagrams
    ];
    
    # Include only the necessary Lua files in the runtime
    extraFiles = {
      "lua/config/nvchad-config.lua".source = ../lua/config/nvchad-config.lua;
      "lua/config/user-config.lua".source = ../lua/config/user-config.lua;
      "lua/config/fallback.lua".source = ../lua/config/fallback.lua;
      "lua/plugins/snacks-keybinds.lua".source = ../lua/plugins/snacks-keybinds.lua;  # Updated filename
    };
    
    # Load our Lua configurations in the right order
    extraConfigLua = ''
      -- Add the lua directory to the runtime path
      vim.opt.runtimepath:prepend(vim.fn.stdpath("config"))
      
      -- Load configurations using require (since files are in extraFiles)
      require('config.nvchad-config')
      require('config.fallback')
      require('config.user-config')
      
      -- Load plugin configurations
      require('plugins.snacks-keybinds')
    '';
  };
}
