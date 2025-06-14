{
  config,
  lib,
  pkgs,
  ...
}:
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
    # Helper options
    home.persistence."/persist/home/${config.snowfallorg.user.name}" = {
      directories = config.persistDirs;
      allowOther = true;
    };

    # Global options
    persistDirs = [
      ".ssh"
      ".config/sops/age"
      ".local/share/zoxide"
    ];
    home.packages = with pkgs; [ ripgrep ];
    programs = {
      zoxide.enable = true;
      nix-index.enable = true;
      nix-index-database.comma.enable = true;
      ssh = {
        enable = true;
        extraConfig = ''
          Host *
            SetEnv TERM=xterm-256color
        '';
      };
    };

    home.stateVersion = "24.11";
  };
}
