{
  inputs = {
    # nixos-unstable provides a binary cache for all packages.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # flake-parts lets us define flake modules.
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{ self, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ inputs.flake-parts.flakeModules.modules ];
      systems = [ "x86_64-linux" ];
      perSystem =
        { pkgs, ... }:
        {
          packages.default = pkgs.hello;
        };
    };
}
