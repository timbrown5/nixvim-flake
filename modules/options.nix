# Modified version of modules/options.nix with duplicate keybindings removed

{ ... }:
{
  # Global options
  globalOpts = {
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

  # General keybindings
  keymaps = [
    # Basic operations
    {
      key = "<leader>w";
      action = "<cmd>w<CR>";
      mode = "n";
      options.desc = "Save file";
    }
    {
      key = "<leader>q";
      action = "<cmd>q<CR>";
      mode = "n";
      options.desc = "Quit";
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
    # Select all
    {
      key = "<C-a>";
      action = "gg<S-v>G";
      mode = "n";
      options.desc = "Select all";
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

    # Split management
    {
      key = "<leader>sv";
      action = "<C-w>v";
      mode = "n";
      options.desc = "Split window vertically";
    }
    {
      key = "<leader>sh";
      action = "<C-w>s";
      mode = "n";
      options.desc = "Split window horizontally";
    }
    {
      key = "<leader>se";
      action = "<C-w>=";
      mode = "n";
      options.desc = "Make splits equal size";
    }
    {
      key = "<leader>sx";
      action = "<cmd>close<CR>";
      mode = "n";
      options.desc = "Close current split";
    }

    # Tab operations
    {
      key = "<leader>to";
      action = "<cmd>tabnew<CR>";
      mode = "n";
      options.desc = "Open new tab";
    }
    {
      key = "<leader>tx";
      action = "<cmd>tabclose<CR>";
      mode = "n";
      options.desc = "Close current tab";
    }
    {
      key = "<leader>tn";
      action = "<cmd>tabn<CR>";
      mode = "n";
      options.desc = "Go to next tab";
    }
    {
      key = "<leader>tp";
      action = "<cmd>tabp<CR>";
      mode = "n";
      options.desc = "Go to previous tab";
    }
    {
      key = "<leader>tf";
      action = "<cmd>tabnew %<CR>";
      mode = "n";
      options.desc = "Open current buffer in new tab";
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
    # Normal mode snipe
    {
      key = "s";
      action = "<cmd>lua require('snipe').snipe()<CR>";
      mode = "n";
      options.desc = "Snipe";
    }
    {
      key = "S";
      action = "<cmd>lua require('snipe').snipe({ backwards = true })<CR>";
      mode = "n";
      options.desc = "Snipe backwards";
    }

    # Operator mode snipe (for commands like 'ds' to delete to a snipe target)
    {
      key = "s";
      action = "<cmd>lua require('snipe').snipe({ operator = true })<CR>";
      mode = "o";
      options.desc = "Snipe operator";
    }
  ];

  # Better paste override is removed since it's handled in the keybinds/init.lua file
}
