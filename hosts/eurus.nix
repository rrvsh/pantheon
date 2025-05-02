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
        address = "103.179.44.32";
        prefixLength = 24; # Or 255.255.255.0
      }
    ];
    defaultGateway = "103.179.44.1"; # The gateway from the admin panel
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ]; # DNS servers from the admin panel
  };
}
