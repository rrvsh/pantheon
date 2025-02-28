{ pkgs, config, inputs, ... }:
let
  hyprland-pkgs = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  hardware = {
    graphics = {
      enable = true;
      package = hyprland-pkgs.mesa.drivers;
      extraPackages = with pkgs; [
        nvidia-vaapi-driver
        ocl-icd
        cudaPackages.cudatoolkit
      ];
    };
    nvidia = {
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };

  environment.variables = {
    NIXOS_OZONE_WL = "1"; # Hint to electron apps to use Wayland
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct"; # Set VAAPI driver backend
  };

  environment.systemPackages = with pkgs; [
    clinfo
    pciutils
  ];
}
