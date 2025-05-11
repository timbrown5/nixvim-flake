# NixVim - Modular Neovim Configuration

A batteries-included, modular Neovim configuration using Nix Flakes and NixVim. This setup provides a powerful, language-aware IDE experience with lazy-loading for optimal performance.

<div align="center">
  <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/previews/macchiato.webp" alt="Default Theme: Catppuccin Macchiato" width="600">
  <p><em>Default Theme: Catppuccin Macchiato</em></p>
</div>

## Features

- **Modular Architecture**: Organized into logical components for easy maintenance
- **Lazy Loading**: LSP servers and plugins only load when needed
- **Catppuccin Theme**: Beautiful and modern Macchiato color scheme by default
- **IDE Features**: Language servers, completion, diagnostics, and debugging
- **Custom Key Mappings**: Intuitive shortcuts for common operations
- **Language Support**: Specialized configurations for Python, Nix, Lua, Terraform, and C
- **Clipboard Integration**: Works seamlessly across Linux and macOS
- **Snacks Explorer/Picker**: Modern replacements for neotree and telescope

## Installation

### Prerequisites

- Nix package manager with flakes enabled
- Git

### Quick Install

```bash
# Clone the repository
git clone https://github.com/your-username/nixvim-config.git
cd nixvim-config

# Run directly from the repository
nix run .

# Or build and install
nix build
./result/bin/nvim
```

### System Integration

Add to your `configuration.nix` or `home.nix`:

```nix
{
  inputs.nixvim-config.url = "github:your-username/nixvim-config";
  
  outputs = { self, nixpkgs, nixvim-config, ... }: {
    # For NixOS
    nixosConfigurations.your-hostname = {
      environment.systemPackages = [ nixvim-config.packages.${system}.default ];
    };
    
    # Or for Home Manager
    homeConfigurations.your-username = {
      home.packages = [ nixvim-config.packages.${system}.default ];
    };
  };
}
```

## Optional Dependencies

This configuration includes optional dependencies that enhance functionality:

### Installation with Optional Dependencies

You can enable all optional dependencies with a single flag:

```nix
# In your flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixvim-config.url = "github:timbrown5/nixvim-flake";
  };
  
  outputs = { self, nixpkgs, nixvim-config, ... }: {
    # Enable all optional dependencies
    nixosConfigurations.your-hostname = {
      environment.systemPackages = [ 
        nixvim-config.packages.${system}.mkNvimWithTheme {
          enableOptionalDeps = true;  # Enable all optional dependencies
        }
      ];
    };
    
    # Or use the pre-configured full version with all dependencies
    homeConfigurations.your-username = {
      home.packages = [ nixvim-config.packages.${system}.nvimFull ];
    };
  };
}

## Core Plugins

- **Snacks.nvim**: File explorer and picker
- **Leap.nvim**: Quick navigation (snipe functionality)
- **LSP**: Language Server Protocol support
- **nvim-cmp**: Completion engine
- **DAP**: Debug Adapter Protocol support
- **Treesitter**: Advanced syntax highlighting
- **Dashboard**: Beautiful start screen
- **Catppuccin**: Modern colorscheme

## Keyboard Shortcuts

> All shortcuts use `Space` as the leader key

### General

| Shortcut      | Description                    |
|---------------|--------------------------------|
| `<leader>f`   | Format document                |
| `<leader>d`   | Delete without copying         |
| `<leader>dd`  | Delete line without copying    |
| `<leader>p`   | Paste from yank register (0)   |
| `<leader>P`   | Paste before from yank register|

### Navigation

| Shortcut      | Description                    |
|---------------|--------------------------------|
| `<leader>e`   | Toggle Snacks Explorer         |
| `<leader>ff`  | Find Files with Snacks         |
| `<leader>fg`  | Live Grep with Snacks          |
| `<leader>fb`  | Find Buffers with Snacks       |
| `s{char}{char}` | Jump forward (Leap/Snipe)    |
| `S{char}{char}` | Jump backward (Leap/Snipe)   |

### LSP

| Shortcut      | Description                    |
|---------------|--------------------------------|
| `<leader>ca`  | Code Action                    |
| `<leader>rn`  | Rename symbol                  |
| `gd`          | Go to Definition               |
| `gr`          | References                     |
| `K`           | Hover Documentation            |

### Debugging

| Shortcut      | Description                    |
|---------------|--------------------------------|
| `<leader>Db`  | Toggle Breakpoint              |
| `<leader>Dc`  | Continue                       |
| `<leader>Dj`  | Step Over                      |
| `<leader>Dk`  | Step Back                      |
| `<leader>Dl`  | Step Into                      |
| `<leader>Dq`  | Terminate                      |
| `<leader>Dr`  | Open REPL                      |
| `<leader>Du`  | Toggle Debug UI                |

### Python (with Ruff)

| Shortcut      | Description                    |
|---------------|--------------------------------|
| `<leader>pr`  | Run Python file                |
| `<leader>pt`  | Run pytest                     |
| `<leader>pf`  | Format with Ruff               |
| `<leader>pi`  | Organize imports with Ruff     |

### Nix

| Shortcut      | Description                    |
|---------------|--------------------------------|
| `<leader>ne`  | Edit flake.nix                 |
| `<leader>nb`  | Run nix build                  |
| `<leader>nf`  | Update flake inputs            |

### Terraform

| Shortcut      | Description                    |
|---------------|--------------------------------|
| `<leader>ti`  | Terraform init                 |
| `<leader>tp`  | Terraform plan                 |
| `<leader>ta`  | Terraform apply                |
| `<leader>tv`  | Terraform validate             |

## Language Support

### Python
- **LSP**: Pyright for type checking and intellisense
- **Linting/Formatting**: Ruff for fast, comprehensive linting and formatting
- **Debugging**: DAP with Python support
- **Autoformat**: Automatic formatting on save

### Nix
- **LSP**: nil_ls for Nix language support
- **Formatting**: nixfmt integrated
- **Syntax**: Enhanced syntax highlighting with vim-nix
- **Shortcuts**: Quick access to common Nix commands

### Lua
- **LSP**: lua-ls with Neovim API awareness
- **Formatting**: Built-in formatter configured
- **Snippets**: Common Vim API expansions
- **Completions**: Neovim-aware completions

### Terraform
- **LSP**: terraformls for HCL support
- **Linting**: tflint integration
- **Syntax**: vim-terraform for enhanced highlighting
- **Commands**: Quick access to common Terraform operations

### C/C++
- **LSP**: clangd for advanced code intelligence
- **Debugging**: GDB integration through DAP
- **Completion**: Full type-aware completions

## Architecture

The configuration is organized into modular components:

```
.
├── flake.nix           # Main entry point
└── modules/
    ├── base.nix        # Core Vim settings
    ├── ui.nix          # Theme and UI components
    ├── lsp.nix         # Language server and completion
    ├── keymaps.nix     # Key mappings
    ├── plugins.nix     # Plugin setup
    ├── debugger.nix    # Debugging configuration
    ├── filetype-config.nix # Language-specific settings
    └── ruff-config.nix # Python formatter configuration
```

## Customization

### Using Custom Themes

You can add your own custom themes by using the `mkCustomTheme` function:

```nix
# In a separate flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixvim-config.url = "github:your-username/nixvim-config";
  };

  outputs = { self, nixpkgs, nixvim-config }: {
    packages.x86_64-linux.default = nixvim-config.packages.x86_64-linux.mkCustomTheme {
      themeName = "awesome-theme";  # Name used with :colorscheme command
      themePlugin = pkgs.vimPlugins.awesome-theme;  # Your theme plugin
      
      # Optional overlay if your theme isn't in nixpkgs yet
      overlay = final: prev: {
        vimPlugins = prev.vimPlugins // {
          awesome-theme = final.vimUtils.buildVimPlugin {
            name = "awesome-theme";
            src = final.fetchFromGitHub {
              owner = "author";
              repo = "awesome-theme";
              rev = "v1.0";
              sha256 = "sha256-...";
            };
          };
        };
      };
    };
  };
}
```

See the `examples/custom-theme.nix` file for a complete example.

### Modifying Configuration

To modify other aspects of the configuration:

1. Edit the appropriate module file for the component you want to change
2. Run `nix develop` to enter a shell with your changes
3. Test your changes with `nvim`
4. Build with `nix build` when satisfied

## Credits

- [NixVim](https://github.com/nix-community/nixvim)
- [Catppuccin](https://github.com/catppuccin/nvim)
- [Snacks.nvim](https://github.com/tjdevries/snacks.nvim)
- [Leap.nvim](https://github.com/ggandor/leap.nvim)
- [Ruff](https://github.com/charliermarsh/ruff)

## Disclaimer

This README and the NixVim configuration were generated with assistance from Claude, an AI assistant by Anthropic. While the configuration is fully functional, you may want to review and customize it to meet your specific needs.
