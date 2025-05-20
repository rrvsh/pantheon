{
  lib,
  config,
  pkgs,
  ...
}:
{
  config = lib.mkIf (config.hardware.gpu == "nvidia") (
    lib.mkMerge [
      {
        #TODO: Setup CUDA
        hardware.graphics.enable = true;
        hardware.graphics.extraPackages = with pkgs; [
          nvidia-vaapi-driver
        ];
        services.xserver.videoDrivers = [ "nvidia" ];
        hardware.nvidia.open = true;
        hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest;
        nixpkgs.config.allowUnfree = true;
        environment.variables = {
          LIBVA_DRIVER_NAME = "nvidia";
          __GLX_VENDOR_LIBRARY_NAME = "nvidia";
          NVD_BACKEND = "direct";
        };
      }
    ]
  );
}
