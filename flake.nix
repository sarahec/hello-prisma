{
  description = "Development setup for workind with Prisma, SQLite, and nx";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.default = pkgs.mkShell {
        packages = [ 
          pkgs.bashInteractive
          pkgs.cypress
          pkgs.nodejs-18_x
          pkgs.nodePackages.prisma
          pkgs.openssl
          pkgs.sqlite
        ];
        shellHook = ''
          export CYPRESS_INSTALL_BINARY=0
          export CYPRESS_RUN_BINARY=${pkgs.cypress}/bin/Cypress
          npm set prefix ~/.npm-global
          export PATH=$PATH:~/.npm-global/bin
        '';
      };
    });
}
