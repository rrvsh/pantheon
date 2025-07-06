{
  flake.modules.nixos.default = {
    system.stateVersion = "25.11";
  };
  flake.modules.homeManager.default =
    { osConfig, ... }:
    {
      home.stateVersion = osConfig.system.stateVersion;
    };
}
