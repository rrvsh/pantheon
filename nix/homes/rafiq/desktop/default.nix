{ lib, inputs, ... }:
{
  flake.modules.homeManager.rafiq =
    { pkgs, config, ... }:
    let
      inherit (lib.modules) mkIf;
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
        };
      };
      home = {
        packages = with pkgs; [
          prismlauncher
          tor-browser
          vlc
        ];
        sessionVariables = {
          BROWSER = "firefox";
          TERMINAL = "ghostty";
        };
      };
      programs = {
        obs-studio.enable = true;
        vesktop.enable = true;
        thunderbird.enable = true;
        thunderbird.profiles.rafiq.isDefault = true;
        # ghostty is broken on nix-darwin
        ghostty.settings.confirm-close-surface = false;
        firefox = {
          enable = true;
          inherit profiles;
        };
      };
    };
}
