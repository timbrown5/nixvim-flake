# Example of using a custom theme with a Nix overlay

{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixvim-config.url = "path:./nixvim-config"; # Replace with actual path or git URL
  };

  outputs = { self, nixpkgs, nixvim-config }: 
    let
      # Define systems you want to support
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      
      # Helper function to generate per-system outputs
      forAllSystems = nixpkgs.lib.genAttrs systems;
      
      # Example custom theme: GitHub theme
      customThemeOverlay = final: prev: {
        vimPlugins = prev.vimPlugins // {
          github-nvim-theme = final.vimUtils.buildVimPlugin {
            name = "github-nvim-theme";
            src = final.fetchFromGitHub {
              owner = "projekt0n";
              repo = "github-nvim-theme";
              rev = "d92e1143e5aaa0d7df28a26dd8ee2102df2cadd8"; # Use a specific commit/tag
              sha256 = "sha256-Pkp0JiXNIBtIJMF9iiWlQxELGReq/kZoyp1h79lFqQA="; # Replace with actual hash
            };
          };
        };
      };
      
    in {
      # Provide an example custom theme for each system
      packages = forAllSystems (system: {
        # Custom theme using the mkCustomTheme function
        default = nixvim-config.packages.${system}.mkCustomTheme {
          themeName = "github-theme"; # Name to use in Neovim colorscheme command
          themePlugin = (import nixpkgs { 
            inherit system;
            overlays = [ customThemeOverlay ];
          }).vimPlugins.github-nvim-theme; # Provide the plugin
          overlay = customThemeOverlay; # Pass the overlay
        };
      });
    };
}
