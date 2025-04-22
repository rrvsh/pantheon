{ lib, type, ... }:
{
  imports =
    [
      ../nixosModules
      ../configs/boot.nix
      ../configs/nix-config.nix
      ../configs/security.nix
      ../configs/users.nix
      ../configs/networking.nix
      ../configs/shell.nix
      ../configs/programs/stylix.nix
    ]
    ++ lib.optionals (type == "graphical") [
      ../configs/graphical.nix
    ];
  nixosModules.enable = true;
}
