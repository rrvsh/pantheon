{
  flake.modules = {
    nixos.default = {
      persistFiles = [ "/etc/machine-id" ];
      persistDirs = [ "/var/lib/systemd" ];
      time.timeZone = "Asia/Singapore";
      i18n.defaultLocale = "en_US.UTF-8";
      system.stateVersion = "25.11";
    };
    homeManager.default.home.stateVersion = "25.11";
    darwin.default =
      { self, ... }:
      {
        system.configurationRevision = self.rev or self.dirtyRev or null;
        system.stateVersion = 6;
      };
  };
}
