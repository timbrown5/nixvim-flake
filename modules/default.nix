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
    
    # Include Lua files in the runtime
    extraFiles = {
      "lua/keybinds/init.lua".source = ../lua/keybinds/init.lua;
      "lua/keybinds/general.lua".source = ../lua/keybinds/general.lua;
      "lua/keybinds/navigation.lua".source = ../lua/keybinds/navigation.lua;
      "lua/keybinds/file_tree.lua".source = ../lua/keybinds/file_tree.lua;
      "lua/keybinds/snacks_picker.lua".source = ../lua/keybinds/snacks_picker.lua;
      "lua/keybinds/snacks.lua".source = ../lua/keybinds/snacks.lua;
      "lua/keybinds/lsp.lua".source = ../lua/keybinds/lsp.lua;
      "lua/keybinds/git.lua".source = ../lua/keybinds/git.lua;
      "lua/keybinds/clipboard.lua".source = ../lua/keybinds/clipboard.lua;
      "lua/keybinds/terminal.lua".source = ../lua/keybinds/terminal.lua;
      "lua/keybinds/tabs.lua".source = ../lua/keybinds/tabs.lua;
      "lua/keybinds/diagnostics.lua".source = ../lua/keybinds/diagnostics.lua;
      "lua/config/nvchad-config.lua".source = ../lua/config/nvchad-config.lua;
      "lua/config/user-config.lua".source = ../lua/config/user-config.lua;
      "lua/config/fallback.lua".source = ../lua/config/fallback.lua;
      "lua/config/keybindings.lua".source = ../lua/config/keybindings.lua;
    };
    
    # Load our Lua configurations in the right order
    extraConfigLua = ''
      -- Add the lua directory to the runtime path
      vim.opt.runtimepath:prepend(vim.fn.stdpath("config"))
      
      -- Load configurations using require (since files are in extraFiles)
      require('config.nvchad-config')
      require('config.fallback')
      require('config.user-config')
      require('config.keybindings')
    '';
  };
}
