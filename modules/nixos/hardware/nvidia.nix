{
  lib,
  config,
  pkgs,
  ...
}:
{
  config = lib.mkIf (config.hardware.gpu == "nvidia") {
    hardware = {
      graphics.enable = true;
      graphics.extraPackages = with pkgs; [
        nvidia-vaapi-driver
      ];
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
  };
}
