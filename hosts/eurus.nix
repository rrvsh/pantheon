{
  imports = [
    ../configs/filesystems/impermanence.nix
  ];
  boot-config.bootloader = "systemd-boot";
  hardware-config.cpu = "amd";
  networking = {
    interfaces.enp3s0.useDHCP = false; # Disable DHCP, we use static IP
    interfaces.enp3s0.ipv4.addresses = [
      {
        address = "160.191.77.168";
        prefixLength = 24; # Or 255.255.255.0
      }
    ];
    defaultGateway = "160.191.77.1"; # The gateway from the admin panel
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ]; # DNS servers from the admin panel
  };
}
