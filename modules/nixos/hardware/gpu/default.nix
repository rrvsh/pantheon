{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkMerge
    mkIf
    mkEnableOption
    singleton
    ;
  cfg = config.hardware.gpu;
in
{
  options.hardware.gpu = {
    nvidia.enable = mkEnableOption "";
  };
  config = mkMerge [
    (mkIf cfg.nvidia.enable {
      hardware = {
        graphics.enable = true;
        graphics.extraPackages = singleton pkgs.nvidia-vaapi-driver;
        nvidia.open = true;
        nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest;
      };
      services.xserver.videoDrivers = [ "nvidia" ];
      nixpkgs.config.allowUnfree = true;
      environment.variables = {
        LIBVA_DRIVER_NAME = "nvidia";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        NVD_BACKEND = "direct";
      };
      nix.settings.substituters = [ "https://cuda-maintainers.cachix.org" ];
      nix.settings.trusted-public-keys = [
        "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      ];
    })
  ];
}
