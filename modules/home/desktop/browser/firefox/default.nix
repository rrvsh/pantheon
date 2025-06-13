{
  osConfig,
  lib,
  inputs,
  system,
  ...
}:
let
  inherit (builtins) map listToAttrs;
  inherit (lib) mkIf;
  inherit (lib.lists) findFirstIndex;
  inherit (inputs.nur.legacyPackages.${system}.repos.rycee) firefox-addons;
  cfg = osConfig.desktop.browser.firefox;
  profileCfg = id: {
    inherit id;
    #TODO: move this into an option?
    settings = {
      "extensions.autoDisableScopes" = 0; # Auto enable extensions
    };
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
  profiles = listToAttrs (
    map (name: {
      inherit name;
      # If there are duplicate profile names, findFirstIndex will cause issues.
      # We sanitize the input in nixosModules.desktop to avoid this.
      value = profileCfg (findFirstIndex (x: x == name) null cfg.syncedProfiles);
    }) cfg.syncedProfiles
  );
in
{
  config = mkIf cfg.enable {
    home.persistence."/persist/home/rafiq".directories = [ ".mozilla/firefox" ];
    home.sessionVariables.BROWSER = "firefox";
    programs.firefox = {
      enable = true;
      inherit profiles;
    };
    stylix.targets.firefox = {
      profileNames = cfg.syncedProfiles;
      colorTheme.enable = true;
    };
  };
}
