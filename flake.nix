{
  description = "NixVim + NvChad Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nixvim, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        nixvim' = nixvim.legacyPackages.${system};
        
        nvimConfig = nixvim'.makeNixvimWithModule {
          inherit pkgs;
          module = ./modules;
          # You can add extra special args here if needed
          # extraSpecialArgs = { inherit self; };
        };
      in
      {
        packages = {
          default = nvimConfig;
          nvim = nvimConfig;
        };

        apps = {
          default = {
            type = "app";
            program = "${nvimConfig}/bin/nvim";
          };
          nvim = self.apps.${system}.default;
        };

        # Development shell with the configured neovim
        devShells = {
          default = pkgs.mkShell {
            buildInputs = [ nvimConfig ];
            shellHook = ''
              echo "NixVim + NvChad environment loaded"
              echo "Run 'nvim' to start"
            '';
          };
        };
      });
}
