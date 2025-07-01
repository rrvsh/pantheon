{
  lib,
  inputs,
  pkgs,
  ...
}:
let
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
{
  home.sessionVariables.BROWSER = "firefox";
  persistDirs = [ ".mozilla/firefox" ];
  programs.firefox = {
    enable = true;
    inherit profiles;
  };
  stylix.targets.firefox.colorTheme.enable = true;
  stylix.targets.firefox.profileNames = syncedProfiles;
}
