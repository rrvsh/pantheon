{
  config,
  lib,
  inputs,
  ...
}:
let
  inherit (lib) mkOption;
  inherit (lib.types) listOf str;
in
{
  imports = [ inputs.impermanence.homeManagerModules.impermanence ];
  options.persistDirs = mkOption {
    type = listOf str;
    default = [ ];
  };
  config = {
    # Helper options
    home.persistence."/persist/home/${config.home.username}" = {
      directories = config.persistDirs;
      allowOther = true;
    };

    # Global options
    persistDirs = [
      # For system activation
      ".ssh"
      ".config/sops/age"
    ];
    programs.ssh.enable = true;
    # To set colors properly when on ssh
    programs.ssh.extraConfig = ''
      Host *
        SetEnv TERM=xterm-256color
    '';
    home.stateVersion = "24.11";
  };
}
