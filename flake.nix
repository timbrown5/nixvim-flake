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

  outputs =
    {
      self,
      nixpkgs,
      nixvim,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        nixvim' = nixvim.legacyPackages.${system};

        nvimConfig = nixvim'.makeNixvimWithModule {
          inherit pkgs;
          module = ./modules;
          # You can add extra special args here if needed
          # extraSpecialArgs = { inherit self; };
        };

        # Wrapper package that includes vi and vim aliases
        nvimWithAliases = pkgs.symlinkJoin {
          name = "nixvim-with-aliases";
          paths = [ nvimConfig ];
          buildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
            ln -sf ${nvimConfig}/bin/nvim $out/bin/vi
            ln -sf ${nvimConfig}/bin/nvim $out/bin/vim
          '';
        };
      in
      {
        packages = {
          default = nvimWithAliases;
          nvim = nvimWithAliases;
        };

        apps = {
          default = {
            type = "app";
            program = "${nvimConfig}/bin/nvim";
          };
          nvim = self.apps.${system}.default;
          vi = {
            type = "app";
            program = "${nvimConfig}/bin/nvim";
          };
          vim = {
            type = "app";
            program = "${nvimConfig}/bin/nvim";
          };
        };

        # Development shell with the configured neovim
        devShells = {
          default = pkgs.mkShell {
            buildInputs = [ nvimWithAliases ];
            shellHook = ''
              echo "NixVim + NvChad environment loaded"
              echo "Run 'nvim', 'vim', or 'vi' to start"
            '';
          };
        };
      }
    );
}
