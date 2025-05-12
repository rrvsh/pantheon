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
  config = lib.mkMerge [
    {
      home-manager.users."${username}".home.packages = with pkgs; [
        pulsemixer
      ];
    }
  ];
}
