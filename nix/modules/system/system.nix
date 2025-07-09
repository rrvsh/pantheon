{
  flake.modules = {
    nixos.default = {
      persistFiles = [ "/etc/machine-id" ];
      persistDirs = [ "/var/lib/systemd" ];
      time.timeZone = "Asia/Singapore";
      i18n.defaultLocale = "en_US.UTF-8";
      system.stateVersion = "25.11";
    };
    homeManager.default =
      { osConfig, ... }:
      {
        home.stateVersion = osConfig.system.stateVersion;
      };
    darwin.default.system.stateVersion = 6;
  };
}
