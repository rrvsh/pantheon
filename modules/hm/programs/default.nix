{
  config,
  lib,
  pkgs,
  ...
}:
let
  username = config.nixosModules.mainUser;
in
{
  imports = [
    ./hyprland.nix
    ./editor.nix
  ];

  config = lib.mkMerge [
    {
      home-manager.users."${username}".home.packages = with pkgs; [
        pulsemixer
      ];
    }
  ];
}
