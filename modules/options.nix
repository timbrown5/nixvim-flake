{ config, lib, ... }:
with lib;
{
  config = {
    opts = {
      number = true;
      relativenumber = true;

      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      autoindent = true;

      wrap = false;
      scrolloff = 8;
      sidescrolloff = 8;
      signcolumn = "yes";
      cursorline = true;

      ignorecase = true;
      smartcase = true;
      hlsearch = true;

      swapfile = false;
      backup = false;
      undofile = true;

      updatetime = 300;
      timeout = true;
      timeoutlen = 1000;

      termguicolors = true;

      splitbelow = true;
      splitright = true;

      mouse = "a";

      completeopt = "menuone,noselect";
    };

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps = [
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
      {
        key = "jk";
        action = "<Esc>";
        mode = "i";
        options.desc = "Exit insert mode";
      }
      {
        key = "U";
        action = "<C-r>";
        mode = "n";
        options.desc = "Redo (also <C-r>)";
      }
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
        key = "x";
        action = "\"_x";
        mode = "n";
        options.desc = "Delete char without yanking";
      }

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

      {
        key = "<leader>bf";
        action = "<cmd>lua require('conform').format({ async = true, lsp_fallback = true })<CR>";
        mode = "n";
        options.desc = "Format buffer with Conform";
      }
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
    ];
  };
}
