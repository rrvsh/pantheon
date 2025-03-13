{
  pkgs,
  config,
  ...
}: {
  # Should not be needed because we set modesetting.enable = true;
  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia-drm.fbdev=1"
  ];
  nixpkgs.config.nvidia.acceptLicense = true;
  services.xserver.videoDrivers = ["nvidia"];
  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };
  hardware = {
    enableRedistributableFirmware = true;
    nvidia-container-toolkit.enable = true;
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        nvidia-vaapi-driver # hardware acceleration
      ];
    };
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
  };
}
