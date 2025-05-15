{ ... }: {
  # Global options
  globalOpts = {
    # Line numbers
    number = true;
    relativenumber = true;
    
    # Tabs
    tabstop = 2;
    shiftwidth = 2;
    expandtab = true;
    autoindent = true;
    
    # UI
    wrap = false;
    scrolloff = 8;
    sidescrolloff = 8;
    signcolumn = "yes";
    
    # Search
    ignorecase = true;
    smartcase = true;
    hlsearch = true;
    
    # Backup
    swapfile = false;
    backup = false;
    undofile = true;
    
    # Performance
    updatetime = 300;
    timeout = true;
    timeoutlen = 1000;
    
    # Colors
    termguicolors = true;
    
    # Splits
    splitbelow = true;
    splitright = true;
    
    # Mouse
    mouse = "a";
    
    # Completion
    completeopt = "menuone,noselect";
  };
}
