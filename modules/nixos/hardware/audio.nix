{ config, lib, ... }:
{
  config = {
    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };
}
