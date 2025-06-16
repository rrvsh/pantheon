{ config, lib, ... }:
let
  inherit (lib) singleton mkOption;
  inherit (lib.types) enum;
  cfg = config.hardware.platform;
in
{
  options.hardware.platform = mkOption {
    type = enum [
      "amd"
      "intel"
    ];
  };
  config = {
    hardware.cpu.${cfg}.updateMicrocode = true;
    boot.kernelModules = singleton "kvm-${cfg}";
  };
}
