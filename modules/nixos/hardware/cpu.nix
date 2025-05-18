{ config, lib, ... }:
{
  config = lib.mkMerge [
    (lib.mkIf (config.hardware.platform == "amd"){
  hardware.cpu.amd.updateMicrocode = true;
  boot.kernelModules = [ "kvm-amd" ];
    })
  ];
}
