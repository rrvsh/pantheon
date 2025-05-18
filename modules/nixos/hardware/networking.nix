{ config, lib, ... }:
{
  config = lib.mkMerge [
    {
  networking.useDHCP = lib.mkDefault true;
  networking.hostName = config.system.hostname;
  networking.networkmanager.enable = true;
    }
  ];
}
