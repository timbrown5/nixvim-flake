{ config, lib, ... }:
with lib;
{
  config = mkForce {
    opts = {
      # Line numbers
      number = true;
      relativenumber = true;

      # Tabs - these should be sufficient for 2-space indentation
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      autoindent = true;

      # UI
      wrap = false;
      scrolloff = 8;
      sidescrolloff = 8;
      signcolumn = "yes";
      cursorline = true;

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

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    # General keybindings - core set that should be available even when fallbacks kick in
    keymaps = [
      # Basic operations
      {
        key = "<leader>w";
        action = "<cmd>w<CR>";
        mode = "n";
        options.desc = "Save file";
      }
      {
        key = "<leader>WQ";
        action = "<cmd>wa | qa<CR>";
        mode = "n";
        options.desc = "Save all and quit all windows";
      }
      {
        key = "<leader>qq";
        action = "<cmd>qa<CR>";
        mode = "n";
        options.desc = "Quit all windows";
      }
      {
        key = "<leader>QQ";
        action = "<cmd>qa!<CR>";
        mode = "n";
        options.desc = "Quit all without saving";
      }
      # Better escape
      {
        key = "jk";
        action = "<Esc>";
        mode = "i";
        options.desc = "Exit insert mode";
      }
      # Redo
      {
        key = "U";
        action = "<C-r>";
        mode = "n";
        options.desc = "Redo (also <C-r>)";
      }
      # Move lines
      {
        key = "<A-j>";
        action = ":m .+1<CR>==";
        mode = "n";
        options.desc = "Move line down";
      }
      {
        key = "<A-k>";
        action = ":m .-2<CR>==";
        mode = "n";
        options.desc = "Move line up";
      }
      {
        key = "<A-j>";
        action = ":m '>+1<CR>gv=gv";
        mode = "v";
        options.desc = "Move selection down";
      }
      {
        key = "<A-k>";
        action = ":m '<-2<CR>gv=gv";
        mode = "v";
        options.desc = "Move selection up";
      }
      # Better indenting
      {
        key = "<";
        action = "<gv";
        mode = "v";
        options.desc = "Indent left";
      }
      {
        key = ">";
        action = ">gv";
        mode = "v";
        options.desc = "Indent right";
      }
      # Center cursor after jumps
      {
        key = "<C-d>";
        action = "<C-d>zz";
        mode = "n";
        options.desc = "Jump down and center";
      }
      {
        key = "<C-u>";
        action = "<C-u>zz";
        mode = "n";
        options.desc = "Jump up and center";
      }
      {
        key = "n";
        action = "nzzzv";
        mode = "n";
        options.desc = "Next search result and center";
      }
      {
        key = "N";
        action = "Nzzzv";
        mode = "n";
        options.desc = "Previous search result and center";
      }

      # Window navigation
      {
        key = "<C-h>";
        action = "<C-w>h";
        mode = "n";
        options.desc = "Navigate window left";
      }
      {
        key = "<C-j>";
        action = "<C-w>j";
        mode = "n";
        options.desc = "Navigate window down";
      }
      {
        key = "<C-k>";
        action = "<C-w>k";
        mode = "n";
        options.desc = "Navigate window up";
      }
      {
        key = "<C-l>";
        action = "<C-w>l";
        mode = "n";
        options.desc = "Navigate window right";
      }

      # WINDOW OPERATIONS - <leader>w prefix (plugin-agnostic)
      {
        key = "<leader>wv";
        action = "<C-w>v";
        mode = "n";
        options.desc = "Window split vertical";
      }
      {
        key = "<leader>wh";
        action = "<C-w>s";
        mode = "n";
        options.desc = "Window split horizontal";
      }
      {
        key = "<leader>we";
        action = "<C-w>=";
        mode = "n";
        options.desc = "Window equal size";
      }
      {
        key = "<leader>wx";
        action = "<cmd>close<CR>";
        mode = "n";
        options.desc = "Window close";
      }

      # TAB OPERATIONS - <leader>t prefix with dual options
      {
        key = "<leader>to";
        action = "<cmd>tabnew<CR>";
        mode = "n";
        options.desc = "Tab open";
      }
      {
        key = "<leader>tx";
        action = "<cmd>tabclose<CR>";
        mode = "n";
        options.desc = "Tab close";
      }
      # Semantic options (existing)
      {
        key = "<leader>tn";
        action = "<cmd>tabn<CR>";
        mode = "n";
        options.desc = "Tab next";
      }
      {
        key = "<leader>tp";
        action = "<cmd>tabp<CR>";
        mode = "n";
        options.desc = "Tab previous";
      }
      # Mnemonic options (new alternatives)
      {
        key = "<leader>tj";
        action = "<cmd>tabn<CR>";
        mode = "n";
        options.desc = "Tab next (alternative)";
      }
      {
        key = "<leader>tk";
        action = "<cmd>tabp<CR>";
        mode = "n";
        options.desc = "Tab previous (alternative)";
      }
      {
        key = "<leader>tf";
        action = "<cmd>tabnew %<CR>";
        mode = "n";
        options.desc = "Tab from current buffer";
      }

      # Clipboard operations (using black hole register)
      {
        key = "<leader>d";
        action = "\"_d";
        mode = "n";
        options.desc = "Delete without yanking";
      }
      {
        key = "<leader>d";
        action = "\"_d";
        mode = "v";
        options.desc = "Delete without yanking";
      }
      {
        key = "<leader>D";
        action = "\"_D";
        mode = "n";
        options.desc = "Delete to end of line without yanking";
      }
      {
        key = "x";
        action = "\"_x";
        mode = "n";
        options.desc = "Delete char without yanking";
      }

      # Paste from yank register
      {
        key = "<leader>p";
        action = "\"0p";
        mode = "n";
        options.desc = "Paste from yank register";
      }
      {
        key = "<leader>P";
        action = "\"0P";
        mode = "n";
        options.desc = "Paste from yank register before cursor";
      }
      {
        key = "<leader>p";
        action = "\"0p";
        mode = "v";
        options.desc = "Paste from yank register";
      }

      # System clipboard
      {
        key = "<leader>y";
        action = "\"+y";
        mode = "n";
        options.desc = "Yank to system clipboard";
      }
      {
        key = "<leader>y";
        action = "\"+y";
        mode = "v";
        options.desc = "Yank to system clipboard";
      }
      {
        key = "<leader>Y";
        action = "\"+Y";
        mode = "n";
        options.desc = "Yank line to system clipboard";
      }

      # Buffer operations (remove bf - it's in conform.nix now)
      {
        key = "<leader>bp";
        action = "ggVG\"_d\"+P";
        mode = "n";
        options.desc = "Paste clipboard over buffer";
      }
      {
        key = "<leader>bd";
        action = "ggVGd";
        mode = "n";
        options.desc = "Delete all of buffer";
      }
      {
        key = "<leader>bD";
        action = "ggVG\"_d";
        mode = "n";
        options.desc = "Delete all of buffer without copying to clipboard";
      }
      {
        key = "<leader>bs";
        action = "ggVG";
        mode = "n";
        options.desc = "Select entire buffer";
      }

      # ORDER OPERATIONS - <leader>o prefix (plugin-agnostic sorting)
      # Alphabetical sorting
      {
        key = "<leader>oa";
        action = ":'<,'>sort<CR>";
        mode = "v";
        options.desc = "Order alphabetical (ascending)";
      }
      {
        key = "<leader>oA";
        action = ":'<,'>sort!<CR>";
        mode = "v";
        options.desc = "Order alphabetical (descending)";
      }
      # Numerical sorting
      {
        key = "<leader>on";
        action = ":'<,'>sort n<CR>";
        mode = "v";
        options.desc = "Order numerical (ascending)";
      }
      {
        key = "<leader>oN";
        action = ":'<,'>sort! n<CR>";
        mode = "v";
        options.desc = "Order numerical (descending)";
      }
      # Unique sorting
      {
        key = "<leader>ou";
        action = ":'<,'>sort u<CR>";
        mode = "v";
        options.desc = "Order unique (remove duplicates)";
      }
      {
        key = "<leader>oU";
        action = ":'<,'>sort! u<CR>";
        mode = "v";
        options.desc = "Order unique descending";
      }

      # SURROUND LOCATE - Additional keybinding (same function as highlight)
      {
        key = "<leader>sl";
        action = "lua require('mini.surround').highlight()";
        mode = "n";
        options.desc = "Surround locate (same as highlight)";
      }
    ];
  };
}
