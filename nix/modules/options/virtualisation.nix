{ lib, config, ... }:
let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
  inherit (cfg.lib.modules) forAllUsers;
  cfg = config.flake;
in
{
  flake.modules.nixos.default =
    { pkgs, config, ... }:
    {
      options = {
        podman.enable = mkEnableOption "";
        podman.distrobox.enable = mkEnableOption "";
      };
      config = mkIf config.podman.enable {
        virtualisation = {
          containers.enable = true;
          podman = {
            enable = true;
            dockerCompat = true;
            defaultNetwork.settings.dns_enabled = true;
          };
        };
        users.users = forAllUsers {
          extraGroups = [ "podman" ];
          autoSubUidGidRange = true;
        };
        home-manager.sharedModules = [
          {
            home.packages = [ pkgs.distrobox ];
            persistDirs = [ ".local/share/containers" ];
          }
        ];
      };
    };
}
