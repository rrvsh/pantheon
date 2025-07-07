{ config, ... }:
let
  cfg = config.flake;
in
{
  allowedUnfreePackages = [
    "nvidia-x11"
    "nvidia-settings"
  ];
  flake.modules.nixos.default =
    {
      config,
      pkgs,
      hostName,
      ...
    }:
    let
      gpu = cfg.manifest.hosts.nixos.${hostName}.machine.gpu or "";
    in
    if gpu == "nvidia" then
      {
        hardware = {
          graphics.enable = true;
          graphics.extraPackages = [ pkgs.nvidia-vaapi-driver ];
          nvidia.open = true;
          nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest;
        };
        services.xserver.videoDrivers = [ "nvidia" ];
        environment.variables = {
          LIBVA_DRIVER_NAME = "nvidia";
          __GLX_VENDOR_LIBRARY_NAME = "nvidia";
          NVD_BACKEND = "direct";
        };
        nix.settings.substituters = [ "https://cuda-maintainers.cachix.org" ];
        nix.settings.trusted-public-keys = [
          "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
        ];
      }
    else
      { };
}
