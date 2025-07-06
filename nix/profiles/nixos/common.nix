{
  flake.profiles.nixos.common =
    { hostName, ... }:
    {
      boot.loader.systemd-boot.enable = true;
      system.stateVersion = "25.05";
      networking = { inherit hostName; };
    };
}
