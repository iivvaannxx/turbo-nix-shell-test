{
    description = "Development flake. Testing turborepo.";

    inputs = {

        nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
        unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        flake-utils.url = "github:numtide/flake-utils";
    };

    outputs = { self, nixpkgs, flake-utils, unstable, ... } @ args: let

        system = "x86_64-linux";

        pkgs         = import nixpkgs    { inherit system; };
        unstablepkgs = import unstable   { inherit system; };

    in rec {

        devShell.x86_64-linux = pkgs.mkShell {
            
            packages = [ 
                
                pkgs.nodejs-slim  
                pkgs.nodePackages_latest.pnpm
                
                unstablepkgs.turbo 
            ];

            shellHook = ''

                # Set it to use the turbo binary from the nix store.
                export TURBO_BINARY_PATH="${unstablepkgs.turbo}/bin/turbo"
            '';
        };
    };
}