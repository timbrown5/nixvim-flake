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
        
        # Simple NvChad-based configuration
        nvchad-config = nixvim'.makeNixvimWithModule {
          inherit pkgs;
          module = {
            # Import all configuration modules
            imports = [ 
              ./modules/nvchad-config.nix
              ./modules/user-config.nix
            ];
          };
        };
      in {
        packages = {
          default = nvchad-config;
        };
        
        devShells.default = pkgs.mkShell {
          buildInputs = [ nvchad-config ];
        };
      };
    };
}
