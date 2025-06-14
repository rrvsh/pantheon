{ lib, config, ... }:
let
  inherit (lib) mkOption;
  inherit (lib.types)
    listOf
    str
    coercedTo
    submodule
    ;
  rootDir = submodule {
    options = {
      directory = mkOption { type = str; };
      user = mkOption {
        type = str;
        default = "root";
      };
      group = mkOption {
        type = str;
        default = "root";
      };
      mode = mkOption {
        type = str;
        default = "0755";
      };
    };
  };
in
{
  options = {
    persistDirs = mkOption {
      type = listOf (coercedTo str (d: { directory = d; }) rootDir);
      default = [ ];
    };
  };

  config = {
    # Helper options
    environment.persistence."/persist".directories = config.persistDirs;

    # Global options
    persistDirs = [
      "/var/lib/systemd"
      "/var/lib/nixos"
    ];
  };
}
