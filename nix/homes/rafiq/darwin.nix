{ lib, ... }:
let
  inherit (lib.modules) mkIf;
in
{
  flake.modules.homeManager.rafiq =
    { pkgs, ... }:
    mkIf pkgs.stdenv.isDarwin {
      home.packages = [
        (import ./_scripts/copy-darwin.nix { inherit pkgs; })
      ];
    };
}
