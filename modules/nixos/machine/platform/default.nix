{ config, lib, ... }:
let
  inherit (lib) singleton mkOption;
  inherit (lib.types) enum;
  cfg = config.machine.platform;
in
{
  options.machine.platform = {
    type = mkOption {
      type = enum [
        "amd"
        "intel"
      ];
    };
  };

  config = {
    hardware.cpu.${cfg.type}.updateMicrocode = true;
    boot.kernelModules = singleton "kvm-${cfg.type}";
  };
}
