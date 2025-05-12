{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = { nixpkgs, nixvim, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem = { pkgs, system, lib, ... }: 
      let
        nixvim' = nixvim.legacyPackages.${system};
        
        # Default theme
        defaultTheme = "catppuccin-macchiato";
        
        # Function to create configuration with a specific theme
        mkNvimWithTheme = {
          theme ? defaultTheme, 
          extraPlugins ? [],
          overlay ? (final: prev: {}),
          # Single flag for all optional dependencies
          enableOptionalDeps ? false
        }:
          let
            # Apply custom overlay to packages
            customPkgs = import nixpkgs {
              inherit system;
              overlays = [ overlay ];
            };
            
            # Build the package list based on enableOptionalDeps flag
            optionalPackages = with pkgs; [
              # Always include these
              gcc
              gnumake
            ] 
            # Add all optional packages if enableOptionalDeps is true
            ++ lib.optionals enableOptionalDeps [
              # Search tools
              ripgrep
              fd
              
              # Language tools
              terraform
              
              # Image and document processing
              imagemagick
              ghostscript
              tectonic
              mermaid-cli
            ];
          in
          nixvim'.makeNixvimWithModule {
            inherit pkgs;
            module = {
              imports = [ 
                ./modules/base.nix
                ./modules/ui.nix
                ./modules/lsp.nix
                ./modules/keymaps.nix
                ./modules/plugins.nix
                ./modules/debugger.nix
                ./modules/filetype-config.nix
                ./modules/ruff-config.nix
                ./modules/health.nix
              ];
              
              # Use standard options instead of _custom
              config = {
                nixvim-config = {
                  inherit theme enableOptionalDeps;
                };
                
                # Add any extra plugins
                plugins = {
                  # Additional plugin configuration if needed
                } // (if (builtins.length extraPlugins) > 0 then { extraPlugins = extraPlugins; } else {});
                
                # Use the conditionally built package list
                extraPackages = optionalPackages;
              };
            };
          };
        
        # Build the default configuration
        nvim = mkNvimWithTheme { 
          theme = defaultTheme; 
          # Default to false for optional dependencies
          enableOptionalDeps = false;
        };
        
        # Add a variant with all optional dependencies enabled
        nvimFull = mkNvimWithTheme {
          theme = defaultTheme;
          enableOptionalDeps = true;
        };
      in {
        packages = {
          default = nvim;
          full = nvimFull;
          
          # Function to create a custom theme package
          mkCustomTheme = { 
            themeName, 
            themePlugin,
            overlay ? (final: prev: {})
          }:
            mkNvimWithTheme {
              theme = themeName;
              extraPlugins = [ themePlugin ];
              inherit overlay;
            };
        };
        
        # Fix for devShell using flake-parts
        devShells.default = pkgs.mkShell {
          buildInputs = [ nvim ];
        };
      };
    };
}
