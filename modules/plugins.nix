{
  config,
  pkgs,
  lib,
  ...
}: {
  # Plugin management with latest API
  plugins = {
    # Core plugins with latest API
    treesitter = {
      enable = true;
      nixGrammars = true; # Use Nix-provided grammars
      ensureInstalled = [ "python" "lua" "nix" "c" "hcl" "terraform" ];
    };
    
    # Code utilities
    gitsigns.enable = true;
    comment-nvim.enable = true;
    indent-blankline = {
      enable = true;
      scope.enabled = true;
    };
    
    # Navigation and UI
    which-key = {
      enable = true;
      # Registrations moved to keymaps.nix
    };
    
    # LuaSnip with latest API
    luasnip = {
      enable = true;
      fromVscode = [];
    };
  };
  
  # External plugins
  extraPlugins = with pkgs.vimPlugins; [
    # Core plugins
    snacks-nvim
    leap-nvim
    
    # Dependencies
    vim-repeat
    plenary-nvim
    
    # Language support
    vim-nix
    vim-terraform
    
    # Theme
    catppuccin-nvim
    
    # LSP extras
    lsp_signature-nvim
  ];
  
  # Snacks configuration
  extraConfigLua = ''
    -- Snacks setup
    require('snacks').setup {
      explorer = { width = 30, side = "left" },
      picker = { previewer = true }
    }

    -- Leap setup
    require('leap').add_default_mappings()
  '';
}
