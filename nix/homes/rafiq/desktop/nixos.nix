{ lib, config, ... }:
let
  inherit (config.manifest) admin;
in
{
  allowedUnfreePackages = [
    "stremio-shell"
    "stremio-server"
    "steam"
    "steam-unwrapped"
  ];
  flake.modules.nixos.graphical =
    { config, pkgs, ... }:
    {
      fonts.packages = [ pkgs.font-awesome ];
      services.getty.autologinUser = admin.username;
      # Start Hyprland at boot only if not connecting through SSH
      environment.loginShellInit = # sh
        ''
          if [[ -z "$SSH_CLIENT" && -z "$SSH_CONNECTION" ]]; then
            if uwsm check may-start; then
              exec uwsm start hyprland-uwsm.desktop
            fi
          fi
        '';
      environment.variables = {
        # Get Electron apps to use Wayland
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
        NIXOS_OZONE_WL = "1";
      };
      programs = {
        hyprland = {
          enable = true;
          # Use UWSM to have each process controlled by systemd init
          withUWSM = true;
        };
        steam = {
          enable = true;
          gamescopeSession.enable = true;
        };
      };
      security.pam.services.hyprlock = { };
      services.sunshine = {
        enable = true;
        capSysAdmin = true;
        openFirewall = true;
        settings = {
          sunshine_name = config.networking.hostName;
          origin_pin_allowed = "wan";
          origin_web_ui_allowed = "wan";
        };
        applications = { };
      };
      # spotifyd
      networking.firewall.allowedTCPPorts = [ 5353 ];
      networking.firewall.allowedUDPPorts = [ 5353 ];
    };
  flake.modules.homeManager.rafiq =
    {
      pkgs,
      config,
      hostName,
      hostConfig,
      ...
    }:
    let
      inherit (lib.modules) mkMerge mkIf;
    in
    mkIf (config.graphical && pkgs.system == "x86_64-linux") {
      stylix.targets.waybar.addCss = false;
      persistDirs = [
        "docs"
        "repos"
        "vids"
        "tmp"
        ".cache/Smart Code ltd/Stremio"
        ".local/share/Smart Code ltd/Stremio"
        ".mozilla/firefox"
        ".tor project"
        ".local/share/Steam"
        ".local/share/PrismLauncher"
        ".config/sunshine"
      ];
      home = {
        packages = with pkgs; [
          wl-clipboard-rs
          stremio
          tor-browser
          vlc
          prismlauncher
        ];
        sessionVariables = {
          LAUNCHER = "fuzzel";
          LOCKSCREEN = "hyprlock";
          NOTIFICATION_DAEMON = "mako";
          STATUS_BAR = "waybar";
        };
      };
      # xdg.configFile."uwsm/env".text = # sh
      #   ''
      #     # Force apps to scale right with Wayland
      #     export GDK_SCALE=${mainMonitor.scale}
      #     export STEAM_FORCE_DESKTOPUI_SCALING=${mainMonitor.scale}
      #   '';
      # xdg.configFile."uwsm/env-hyprland".text = # sh
      #   ''
      #     export GDK_SCALE=${mainMonitor.scale}
      #     export STEAM_FORCE_DESKTOPUI_SCALING=${mainMonitor.scale}
      #   '';
      wayland.windowManager.hyprland = {
        enable = true;
        # This is needed for UWSM
        systemd.enable = false;
        # Null the packages since we use them system wide
        package = null;
        portalPackage = null;
        settings = mkMerge [
          (import ./_hyprland/decoration.nix)
          (import ./_hyprland/keybinds.nix { inherit pkgs; })
          {
            ecosystem.no_update_news = true;
            xwayland.force_zero_scaling = true;
            monitor =
              let
                mainMonitor = hostConfig.machine.monitors.main;
              in
              [
                "${mainMonitor.id}, ${mainMonitor.resolution}@${mainMonitor.refresh-rate}, auto, ${mainMonitor.scale}"
                ", preferred, auto, 1"
              ];
            exec-once = [
              "uwsm app -- $LOCKSCREEN"
              "uwsm app -- $NOTIFICATION_DAEMON"
              "uwsm app -- $STATUS_BAR"
            ];
          }
        ];
      };
      services = {
        spotifyd.enable = true;
        spotifyd.settings.global = {
          device_name = "${hostName}";
          device_type = "computer";
          zeroconf_port = 5353;
        };
        mako.enable = true;
        mako.settings.default-timeout = 10000;
      };
      programs = {
        obs-studio.enable = true;
        fuzzel.enable = true;
        ghostty.enable = true;
        waybar = {
          enable = true;
          settings = [
            {
              layer = "top";
              modules-left = [
                "pulseaudio"
              ];
              modules-right = [
                "battery"
                "clock"
              ];
              "pulseaudio" = {
                format = "{icon} {volume}%";
                format-muted = "";
                format-icons.default = [
                  ""
                  ""
                ];
                on-click = "${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
              };
              "clock" = {
                interval = 1;
                format = "{:%F %T}";
              };
              "battery" = {
                interval = 1;
                bat-compatibility = true;
              };
            }
          ];
          style = # css
            ''
              window#waybar {
                background-color: rgba(0, 0, 0, 0);
              }

              #pulseaudio,
              #battery,
              #clock {
                padding-top: 5px;
                padding-bottom: 5px;
                padding-right: 5px;
                color: #ffffff;
              }
            '';
        };
        hyprlock = {
          enable = true;
          settings = {
            general.hide_cursor = true;
            general.ignore_empty_input = true;
            background.blur_passes = 5;
            background.blur_size = 5;
            label = {
              text = ''hi, $USER.'';
              font_size = 32;
              position = "0, 0";
              halign = "center";
              valign = "center";
              zindex = 1;
              shadow_passes = 5;
              shadow_size = 5;
            };
            input-field = {
              placeholder_text = "";
              fade_on_empty = true;
              size = "200, 45";
              position = "0, -5%";
              halign = "center";
              valign = "center";
              zindex = 1;
              shadow_passes = 5;
              shadow_size = 5;
            };
          };
        };
      };
    };
}
