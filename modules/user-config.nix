{
  config,
  pkgs,
  lib,
  ...
}: {
  # User customizations and extensions go here
  config = {
    # Add more plugins
    extraPlugins = with pkgs.vimPlugins; [
      # Add any additional plugins you want
      # Examples:
      # vim-surround
      # hop-nvim
      # neogit
    ];
    
    # Add more LSP servers
    plugins.lsp.servers = {
      # Uncomment to enable more servers:
      # tsserver.enable = true;
      # gopls.enable = true;
      # rust_analyzer = {
      #   enable = true;
      #   installCargo = true;
      #   installRustc = true;
      # };
    };
    
    # Copy user customization Lua file
    files."lua/config/user-config.lua".source = ../lua/user-config.lua;
    
    # Load user customization Lua file
    extraConfigLua = ''
      -- Load user customizations
      require("config.user-config")
    '';
    
    # Additional options
    opts = {
      # Add more options here
      # Example:
      # wrap = false;
      # scrolloff = 8;
      # sidescrolloff = 8;
    };
  };
}
