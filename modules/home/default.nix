{ config, lib, ... }:
let
  inherit (lib) mkOption;
  inherit (lib.types) listOf str;
in
{
  options = {
    persistDirs = mkOption {
      type = listOf str;
      default = [ ];
    };
  };

  config = {
    home.persistence."/persist/home/${config.snowfallorg.user.name}" = {
      directories = config.persistDirs;
      allowOther = true;
    };

    persistDirs = [
      ".ssh"
      ".config/sops/age"
    ];

    home.stateVersion = "24.11";
  };
}
