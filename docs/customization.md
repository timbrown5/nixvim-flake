# Customization Guide

How to extend and customize your NixVim configuration.

## Adding Plugins

### 1. Add to Nix Configuration

Edit the relevant module in `modules/`:

```nix
# modules/my-plugins.nix
{ pkgs, lib, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    # Add your plugins here
    plugin-name
    another-plugin
  ];

  # Configure if the plugin has NixVim support
  plugins.my-plugin = {
    enable = true;
    settings = {
      # Plugin-specific settings
    };
  };
}
```

### 2. Import the Module

```nix
# modules/default.nix
{
  imports = [
    # ... existing imports
    ./my-plugins.nix
  ];
}
```

## Changing Themes

### Catppuccin Variants

Edit `modules/nvchad.nix`:

```nix
colorschemes.catppuccin = {
  enable = true;
  settings = {
    flavour = "mocha";  # "latte", "frappe", "macchiato", "mocha"
    transparent_background = true;
  };
};
```

### Different Theme Entirely

```nix
# Disable Catppuccin first
colorschemes.catppuccin.enable = false;

# Enable new theme
colorschemes.tokyonight = {
  enable = true;
  settings = {
    style = "night";
  };
};
```

## Adding Formatters

### 1. Add to Conform Configuration

Edit `modules/conform.nix`:

```nix
{
  plugins.conform-nvim = {
    settings = {
      formatters_by_ft = {
        # Add your language and formatter
        rust = [ "rustfmt" ];
        go = [ "goimports" "gofmt" ];
        python = [ "black" "isort" ];
      };
    };
  };

  # Add formatter packages
  extraPackages = with pkgs; [
    rustfmt
    go
    black
    python3Packages.isort
  ];
}
```

### 2. Custom Formatter Settings

```nix
formatters = {
  black = {
    prepend_args = [
      "--line-length"
      "100"  # Custom line length
    ];
  };
};
```

## Adding Keybindings

### 1. Choose Appropriate Namespace

Follow the functional namespace philosophy:

- `<leader>a*` - AI Assistant
- `<leader>b*` - Buffer operations
- `<leader>c*` - Code operations
- `<leader>f*` - Find & Search
- `<leader>s*` - Snippets & Surround
- etc.

### 2. Add to Plugin Configuration

```lua
-- lua/plugins/my-plugin.lua
local function safe_keymap(mode, key, action, opts)
  local ok, error = pcall(vim.keymap.set, mode, key, action, opts)
  if not ok then
    vim.notify("Failed to set keymap " .. key .. ": " .. tostring(error), vim.log.levels.ERROR)
  end
end

-- Choose appropriate namespace based on function
safe_keymap('n', '<leader>cp', '<cmd>MyPluginCommand<CR>', { desc = 'My plugin command' })
```

### 3. Reference in Nix

```nix
# modules/my-plugins.nix
{
  extraFiles = {
    "lua/plugins/my-plugin.lua".source = ../lua/plugins/my-plugin.lua;
  };

  extraConfigLua = lib.mkAfter ''
    require('plugins.my-plugin')
  '';
}
```

### 4. Update Which-Key Groups

```lua
-- lua/plugins/which-key.lua
which_key.add({
  { "<leader>c", group = "󰨞 Code & My Features" },
})
```

## Language Server Configuration

### Adding New LSP

```nix
# modules/core-plugins.nix
{
  plugins.lsp = {
    servers = {
      # Add new language server
      rust_analyzer = {
        enable = true;
        settings = {
          # LSP-specific settings
        };
      };
    };
  };

  extraPackages = with pkgs; [
    rust-analyzer  # Add the LSP package
  ];
}
```

### Custom LSP Settings

```nix
lua_ls = {
  enable = true;
  settings = {
    Lua = {
      diagnostics = {
        globals = [ "vim" "awesome" ];  # Add global variables
      };
      workspace = {
        library = [
          "${pkgs.vimPlugins.plenary-nvim}/lua"
        ];
      };
    };
  };
};
```

## File Organization

```
├── modules/                 # Nix configuration modules
│   ├── default.nix         # Main module imports and core config
│   ├── options.nix         # Neovim options and core keybindings
│   ├── nvchad.nix          # NvChad UI configuration
│   ├── snacks.nix          # Snacks.nvim plugin module
│   ├── core-plugins.nix    # Core plugins (LSP, DAP, etc.)
│   ├── mini.nix            # Mini.nvim configurations
│   ├── luasnip.nix         # Snippet engine configuration
│   ├── codecompanion.nix   # AI assistant configuration
│   └── conform.nix         # Formatting with Conform.nvim
├── lua/
│   ├── config/             # General Neovim configuration
│   │   ├── nvchad-config.lua
│   │   ├── user-config.lua
│   │   ├── fallback.lua
│   │   └── health-check.lua
│   ├── plugins/            # Complete plugin configurations
│   │   ├── snacks.lua      # Snacks keybindings
│   │   ├── debugger.lua    # DAP setup and debugging keybindings
│   │   ├── snipe.lua       # Snipe setup and keybindings
│   │   └── which-key.lua   # Which-key configuration
│   └── codecompanion-config.lua # AI assistant settings
├── snippets/               # Custom snippets
│   ├── all/               # Global snippets
│   └── lua/               # Language-specific snippets
└── docs/                  # Documentation
```

## Advanced Customization

### Custom Lua Functions

```lua
-- lua/config/user-config.lua
-- Add custom functions
local M = {}

function M.toggle_transparency()
  local current = vim.g.transparent_background
  vim.g.transparent_background = not current
  vim.cmd('colorscheme catppuccin')
end

vim.keymap.set('n', '<leader>vt', M.toggle_transparency, { desc = 'Toggle transparency' })

return M
```

### Environment-Specific Configuration

```nix
# Use different settings for work vs personal
let
  isWork = builtins.getEnv "NVIM_PROFILE" == "work";
in
{
  extraConfigLua = ''
    ${if isWork then ''
      -- Work-specific settings
      vim.g.copilot_enabled = false
    '' else ''
      -- Personal settings
      vim.g.copilot_enabled = true
    ''}
  '';
}
```

### Custom Snippets

See [Snippet Management Guide](snippets.md) for details on creating and managing snippets.

## Testing Changes

### 1. Build and Test

```bash
nix build
./result/bin/nvim
```

### 2. Health Check

```vim
:checkhealth nixvim
```

### 3. Debug Issues

```vim
:messages        " View error messages
:lua print(vim.inspect(require('config')))  " Debug Lua config
```

## Contributing Back

When you create useful customizations:

1. **Document your changes** in commit messages
2. **Follow the namespace philosophy** for keybindings
3. **Add appropriate which-key descriptions**
4. **Test thoroughly** with `:checkhealth`
5. **Consider submitting a PR** if it's generally useful

## Common Patterns

### Adding a Simple Plugin

```nix
# 1. Add to extraPlugins
extraPlugins = with pkgs.vimPlugins; [ new-plugin ];

# 2. Configure in Lua
extraConfigLua = ''
  require('new-plugin').setup({
    -- configuration
  })
'';

# 3. Add keybindings following namespace convention
```

### Plugin with Dependencies

```nix
extraPlugins = with pkgs.vimPlugins; [
  main-plugin
  dependency-1
  dependency-2
];
```

### Plugin Not in Nixpkgs

```nix
extraPlugins = [
  (pkgs.vimUtils.buildVimPlugin {
    name = "custom-plugin";
    src = pkgs.fetchFromGitHub {
      owner = "author";
      repo = "plugin-name";
      rev = "commit-hash";
      sha256 = "sha256-hash";
    };
  })
];
```
