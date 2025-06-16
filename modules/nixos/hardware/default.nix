{
  lib,
  config,
  ...
}:
let
  inherit (lib) singleton;
in
{
  imports = [
    ./nvidia.nix
    ./audio.nix
  ];

  options.hardware = {
    gpu = lib.pantheon.mkStrOption;
    platform = lib.pantheon.mkStrOption;
  };

  config = lib.mkMerge [
    {
      services.fwupd.enable = true;
      persistDirs = singleton "/var/lib/bluetooth";
      hardware.bluetooth = {
        enable = true;
        settings.General.Experimental = true;
      };
      hardware.xone.enable = true;
    }
    (lib.mkIf (config.hardware.platform == "amd") {
      hardware.cpu.amd.updateMicrocode = true;
      boot.kernelModules = [ "kvm-amd" ];
    })
    (lib.mkIf (config.hardware.platform == "intel") {
      hardware.cpu.intel.updateMicrocode = true;
      boot.kernelModules = [ "kvm-intel" ];
    })
  ];
}
