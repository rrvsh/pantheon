{ config, lib, ...}:
{
  imports = [
    ./boot.nix
    ./users.nix
    ./localisation.nix
    ./nix-config.nix
    ./secrets.nix
  ];

  options.system = {
   hostname = lib.pantheon.mkStrOption;
   mainUser = lib.pantheon.mkStrOption;
   bootloader = lib.pantheon.mkStrOption;
  };

  config = {
    system.stateVersion = "25.05"; # Did you read the comment?
  };
}
