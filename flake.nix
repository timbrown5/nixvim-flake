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
          overlay ? (final: prev: {})
        }:
          let
            # Apply custom overlay to packages
            customPkgs = import nixpkgs {
              inherit system;
              overlays = [ overlay ];
            };
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
              ];
              
              # Pass theme and custom pkgs to modules
              config = {
                _custom = {
                  inherit theme;
                  customPkgs = customPkgs;
                };
                
                # Add any extra plugins
                extraPlugins = extraPlugins;
              };
            };
          };
        
        # Build the default configuration
        nvim = mkNvimWithTheme { theme = defaultTheme; };
        
        # Function to create a custom package with a custom theme plugin
        mkNvimWithCustomTheme = { 
          themeName, 
          themePlugin,
          overlay ? (final: prev: {})
        }:
          mkNvimWithTheme {
            theme = themeName;
            extraPlugins = [ themePlugin ];
            inherit overlay;
          };
      in {
        packages = {
          default = nvim;
          
          # Function to create a custom theme package
          mkCustomTheme = mkNvimWithCustomTheme;
        };
        
        # Fix for devShell using flake-parts
        devShells.default = pkgs.mkShell {
          buildInputs = [ nvim ];
        };
      };
    };
}
