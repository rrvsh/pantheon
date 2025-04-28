{
  lib,
  hostname,
  type,
  ...
}:
{
  imports =
    [
      ../configs/security.nix
      ../configs/users.nix
      ../configs/shell.nix
      ../configs/programs/stylix.nix
    ]
    ++ lib.optionals (type == "graphical") [
      ../configs/graphical.nix
    ];
  nixosModules.enable = true;
  nixosModules.hostname = hostname;
  hmModules.enable = true;
  nix-config.enable = true;
  boot-config.enable = true;
  hardware-config.usbAutoMount = true;
  nw-config.backend = "networkmanager";
}
