{ lib, inputs, ... }:
{
  allowedUnfreePackages = [
    "stremio-shell"
    "stremio-server"
  ];
  flake.homes.rafiq =
    { osConfig, pkgs, ... }:
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
        #TODO: add default seach unduck and add rest of extensions
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
    mkIf osConfig.desktop.enable {
      persistDirs = [
        "docs"
        "repos"
        "vids"
        "tmp"
        ".cache/Smart Code ltd/Stremio"
        ".local/share/Smart Code ltd/Stremio"
        ".mozilla/firefox"
      ];
      home = {
        packages = with pkgs; [ stremio ];
        sessionVariables = {
          BROWSER = "firefox";
          LAUNCHER = "fuzzel";
          LOCKSCREEN = "hyprlock";
          NOTIFICATION_DAEMON = "mako";
          TERMINAL = "ghostty";
          STATUS_BAR = "waybar";
        };
      };
      # TODO: add gamescope here or in nixos desktop module
      programs = {
        obs-studio.enable = true;
        vesktop.enable = true;
        thunderbird.enable = true;
        thunderbird.profiles.rafiq.isDefault = true;
        firefox = {
          enable = true;
          inherit profiles;
        };
        hyprlock.settings = {
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
              #TODO: review the rest of the modules to see what else can be added
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
        mako.enable = true;
        mako.settings.default-timeout = 10000;
      };
      wayland.windowManager.hyprland.settings = mkMerge [
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
}
