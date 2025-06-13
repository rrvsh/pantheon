{ osConfig, lib, ... }:
let
  inherit (builtins) map listToAttrs;
  inherit (lib.lists) findFirstIndex;
  cfg = osConfig.desktop.browser.firefox;
  profileCfg = id: {
    inherit id;
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
  config = lib.mkIf cfg.enable {
    home.persistence."/persist/home/rafiq".directories = [ ".mozilla/firefox" ];
    home.sessionVariables.BROWSER = "firefox";
    programs.firefox = {
      enable = true;
      inherit profiles;
    };
    stylix.targets.firefox = {
      profileNames = cfg.syncedProfiles;
    };
  };
}
