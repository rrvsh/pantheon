{ lib, inputs, ... }:
{
  allowedUnfreePackages = [
    "stremio-shell"
    "stremio-server"
    "steam"
    "steam-unwrapped"
  ];
  flake.modules.nixos.graphical =
    { config, ... }:
    {
      security.pam.services.hyprlock = { };
      programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
      };
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
      ...
    }:
    let
      inherit (lib.modules) mkMerge mkIf;
      inherit (builtins) map listToAttrs;
      inherit (lib.lists) findFirstIndex;
      inherit (inputs.nur.legacyPackages.${pkgs.stdenv.hostPlatform.system}.repos.rycee) firefox-addons;
      profiles = listToAttrs (
        map (name: {
          inherit name;
          # If there are duplicate profile names, findFirstIndex will cause issues.
          value = profileCfg (findFirstIndex (x: x == name) null syncedProfiles);
        }) syncedProfiles
      );
      syncedProfiles = [
        "rafiq"
        "test"
      ];
      profileCfg = id: {
        inherit id;
        settings."extensions.autoDisableScopes" = 0; # Auto enable extensions
        extensions = {
          force = true;
          packages = with firefox-addons; [
            darkreader
            gesturefy
            sponsorblock
            ublock-origin
          ];
        };
      };
    in
    mkIf config.graphical {
      stylix = {
        image = ./wallpaper.png;
        targets = {
          firefox.colorTheme.enable = true;
          firefox.profileNames = syncedProfiles;
          waybar.addCss = false;
        };
      };
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
          prismlauncher
          stremio
          tor-browser
          vlc
          wl-clipboard-rs
        ];
        sessionVariables = {
          BROWSER = "firefox";
          LAUNCHER = "fuzzel";
          LOCKSCREEN = "hyprlock";
          NOTIFICATION_DAEMON = "mako";
          TERMINAL = "ghostty";
          STATUS_BAR = "waybar";
        };
      };
      programs = {
        fuzzel.enable = true;
        obs-studio.enable = true;
        vesktop.enable = true;
        thunderbird.enable = true;
        thunderbird.profiles.rafiq.isDefault = true;
        firefox = {
          enable = true;
          inherit profiles;
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
        ghostty = {
          enable = true;
          settings = {
            confirm-close-surface = false;
          };
        };
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
      wayland.windowManager.hyprland = {
        enable = true;
        # This is needed for UWSM
        systemd.enable = false;
        # Null the packages since we use them system wide
        package = null;
        portalPackage = null;
        # settings.monitor = [
        #   "${mainMonitor.id}, ${mainMonitor.resolution}@${mainMonitor.refresh-rate}, auto, ${mainMonitor.scale}"
        # ];

        settings = mkMerge [
          (import ./_hyprland/decoration.nix)
          (import ./_hyprland/keybinds.nix { inherit pkgs; })
          {
            ecosystem.no_update_news = true;
            xwayland.force_zero_scaling = true;
            monitor = [ ", preferred, auto, 1" ];
            exec-once = [
              "uwsm app -- $LOCKSCREEN"
              "uwsm app -- $NOTIFICATION_DAEMON"
              "uwsm app -- $STATUS_BAR"
            ];
          }
        ];
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
    };
}
