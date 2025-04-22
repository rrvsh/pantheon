{
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };
  services.acpid = {
    enable = true;
  };
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="pci", DRIVER=="pcieport", ATTR{power/wakeup}="disabled"
  '';
}
