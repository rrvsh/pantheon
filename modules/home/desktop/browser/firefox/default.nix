{ osConfig, lib, ... }:
{
  config = lib.mkIf (osConfig.desktop.browser == "firefox") {
    home.persistence."/persist/home/rafiq".directories = [ ".mozilla/firefox" ];
    home.sessionVariables.BROWSER = "firefox";
    programs.firefox = {
      enable = true;
      profiles.rafiq.id = 0;
      profiles.test.id = 1;
    };
  };
}
