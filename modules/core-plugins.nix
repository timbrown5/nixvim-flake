{ pkgs, ... }: {
  # Additional core plugins
  extraPlugins = with pkgs.vimPlugins; [
    # UI enhancements
    indent-blankline-nvim
    
    # Better quickfix
    trouble-nvim
    
    # Surround operations
    vim-surround
    
    # Better terminal
    toggleterm-nvim
  ];

  plugins = {
    # Icons support (explicitly enable to avoid warnings)
    web-devicons.enable = true;
    
    # Indent guides
    indent-blankline = {
      enable = true;
      settings = {
        scope = {
          enabled = true;
          show_start = true;
        };
      };
    };
    
    # Trouble for better diagnostics (v3)
    trouble = {
      enable = true;
      settings = {
        auto_close = true;
      };
    };
  };
}
