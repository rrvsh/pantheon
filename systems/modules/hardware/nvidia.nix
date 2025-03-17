{
  inputs,
  pkgs,
  config,
  ...
}: {
  # Accept the license by default; needed for some packages.
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
      package = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.mesa.drivers;
      extraPackages = with pkgs; [
        nvidia-vaapi-driver # hardware acceleration
      ];
    };
    nvidia = {
      modesetting.enable = true;
      # powerManagement.enable = true;
      open = false;
      nvidiaSettings = true;
      nvidiaPersistenced = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
  };
  boot.initrd.availableKernelModules = ["nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm"];
}
