{
  config,
  lib,
  ...
}:
let
  username = config.nixosModules.mainUser;
in
{
  config = lib.mkMerge [
    (lib.mkIf config."hardware-config".usbAutoMount {
      home-manager.users.${username}.services.udiskie = {
        enable = true;
        settings = {
          # workaround for
          # https://github.com/nix-community/home-manager/issues/632
          program_options = {
            # replace with your favorite file manager
            file_manager = "yazi";
          };
        };
      };
    })
  ];
}
