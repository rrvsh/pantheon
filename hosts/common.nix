{ lib, type, ... }:
{
  imports =
    [
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
  hmModules.enable = true;
  nix-config.enable = true;
  boot-config.enable = true;
  hardware-config.usbAutoMount = true;
}
