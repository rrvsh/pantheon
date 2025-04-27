{
  config,
  lib,
  ...
}:
let
  moduleName = "fs-config";
  cfg = config."${moduleName}";
in
{
  options = {
    "${moduleName}" = {
      mountHeliosData = lib.mkEnableOption "Mount helios SMB share to /media/helios/data.";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.mountHeliosData {
      fileSystems."/media/helios/data" = {
        device = "//helios/data";
        fsType = "cifs";
      };
    })
  ];
}
