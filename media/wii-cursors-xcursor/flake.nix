{
  description = "Wii Cursor Theme";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    { self, nixpkgs, ... }:
    let
      system = "x86_64-linux"; # Adjust if needed
      pkgs = import nixpkgs { inherit system; };
    in
    {
      packages.${system}.wii-cursor = pkgs.callPackage ./default.nix { };

      defaultPackage.${system} = self.packages.${system}.wii-cursor;
    };
}
