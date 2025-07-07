{
  flake.modules.nixos.default = {
    persistFiles = [ "/etc/machine-id" ];
    persistDirs = [ "/var/lib/systemd" ];
    system.stateVersion = "25.11";
  };
  flake.modules.homeManager.default =
    { osConfig, ... }:
    {
      home.stateVersion = osConfig.system.stateVersion;
    };
}
