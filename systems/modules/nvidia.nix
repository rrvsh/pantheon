{ pkgs, ... }: {
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      # TODO:
      # opencl
      nvidia-vaapi-driver # hardware acceleration
    ];
  };
  # FIXME: hardware.nvidia.open = ;
}
