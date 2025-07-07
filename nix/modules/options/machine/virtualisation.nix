{ lib, config, ... }:
let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
  inherit (lib.lists) optional;
  inherit (config.flake.lib.modules) forAllUsers;
in
{
  flake.modules.nixos.default =
    { pkgs, config, ... }:
    let
      cfg = config.machine.virtualisation;
    in
    {
      options.machine.virtualisation = {
        podman.enable = mkEnableOption "";
        podman.distrobox.enable = mkEnableOption "";
      };
      config = mkIf cfg.podman.enable {
        virtualisation.containers.enable = true;
        virtualisation.podman = {
          enable = true;
          dockerCompat = true;
          defaultNetwork.settings.dns_enabled = true;
        };
        users.users = forAllUsers {
          extraGroups = [ "podman" ];
          autoSubUidGidRange = cfg.podman.distrobox.enable;
        };
        home-manager.sharedModules = optional cfg.podman.distrobox.enable {
          home.packages = [ pkgs.distrobox ];
          persistDirs = [ ".local/share/containers" ];
        };
      };
    };
}
