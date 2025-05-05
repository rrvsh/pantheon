{
  config,
  lib,
  ...
}:
let
  moduleName = "de";
  cfg = config."${moduleName}";
in
{
  options = {
    "${moduleName}" = {
      enable = lib.mkEnableOption "Enable ${moduleName}.";
      type = lib.mkOption {
        type = lib.types.str;
        default = "";
        example = "hyprland";
        description = "What desktop environment should be installed on the host.";
      };
    };
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        # Enable audio and other common config
        security.rtkit.enable = true;
        services.pipewire = {
          enable = true;
          extraConfig = { };
          jack.enable = true;
          pulse.enable = true;
          alsa = {
            enable = true;
            support32Bit = true;
          };
        };
        hardware.bluetooth = {
          enable = true;
          powerOnBoot = true;
        };
      }
      (lib.mkIf config.hmModules.enable {
        home-manager.users."${config.nixosModules.mainUser}".services.spotifyd = {
          enable = true;
          settings = {
            global = {
              device_name = "${config.nixosModules.hostname}";
              device_type = "computer";
              zeroconf_port = 5353;
            };
          };
        };
        networking.firewall.allowedTCPPorts = [ 5353 ];
        networking.firewall.allowedUDPPorts = [ 5353 ];
      })
      (lib.mkIf (cfg.type == "hyprland") {
        environment.loginShellInit = # sh
          ''
            if [[ -z "$SSH_CLIENT" && -z "$SSH_CONNECTION" ]]; then
              if uwsm check may-start; then
                exec uwsm start hyprland-uwsm.desktop
              fi
            fi
          '';

        programs.hyprland = {
          enable = true;
          withUWSM = true;
        };

      })
    ]
  );
}
