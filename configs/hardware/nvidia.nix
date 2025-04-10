{
  inputs,
  pkgs,
  config,
  ...
}:
{
  # Accept the license by default; needed for some packages.
  nixpkgs.config.nvidia.acceptLicense = true;
  nix.settings = {
    substituters = [ "https://cuda-maintainers.cachix.org" ];
    trusted-public-keys = [
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    ];
  };
  services.xserver.videoDrivers = [ "nvidia" ];
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
      open = false;
      nvidiaSettings = true;
      nvidiaPersistenced = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
  };
  boot.initrd.availableKernelModules = [
    "nvidia"
    "nvidia_modeset"
    "nvidia_uvm"
    "nvidia_drm"
  ];
}
