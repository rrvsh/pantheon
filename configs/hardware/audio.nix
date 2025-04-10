{
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    extraConfig = { };
    jack.enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };
}
