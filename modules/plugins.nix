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
      settings.ensure_installed = [ "python" "lua" "nix" "c" "hcl" "terraform" ];
    };
    
    # Code utilities
    gitsigns.enable = true;
    comment.enable = true; # Updated from comment-nvim
    indent-blankline = {
      enable = true;
      settings.scope.enabled = true; # Updated path
    };
    
    # Navigation and UI
    which-key.enable = true;
    
    # LuaSnip with latest API
    luasnip = {
      enable = true;
      fromVscode = [];
    };
    
    # Add mini.nvim plugins with correct format
    mini = {
      enable = true;
      modules = {
        # Each module is an attribute with its own config
        icons = { };  # Empty config is fine for basic setup
      };
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
    
    # Icons
    nvim-web-devicons
    
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
    
    -- Initialize web-devicons
    require('nvim-web-devicons').setup()
    
    -- Configure which-key to use mini.icons
    local has_which_key = pcall(require, 'which-key')
    if has_which_key then
      require('which-key').setup({
        icons = {
          breadcrumb = "»", 
          separator = "➜", 
          group = "+", 
        },
        -- Add this to enable mini.icons integration
        plugins = {
          presets = {
            operators = true,
            motions = true,
            text_objects = true,
            windows = true,
            nav = true,
            z = true,
            g = true,
          },
        },
      })
    end
  '';
}
