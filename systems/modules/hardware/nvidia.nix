{
  pkgs,
  config,
  ...
}: {
  services.xserver.videoDrivers = ["nvidia"];
  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        # TODO:
        # opencl
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
