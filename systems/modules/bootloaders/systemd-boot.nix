{
  boot.loader = {
    timeout = 5;
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
}
