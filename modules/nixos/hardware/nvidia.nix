{ lib, config, pkgs, ... }:
{
  config = lib.mkIf (config.hardware.gpu == "nvidia") (lib.mkMerge [
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
    }
  ]);
}
