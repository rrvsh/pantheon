{
  users.rafiq = {
    primary = true;
    email = "rafiq@rrv.sh";
    alternate-emails = [
      "mohammadrafiq@rrv.sh"
      "mohammadrafiq567@gmail.com"
    ];
    pubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILdsZyY3gu8IGB8MzMnLdh+ClDxQQ2RYG9rkeetIKq8n";
  };

  entrypoints = {
    # For services that should only have one instance across the whole
    # flake, define them here and they will get provisioned on those
    # hosts, with whatever depends on them configured via that hostname.
    nginx.host = "apollo";
    ssh.host = "apollo";
  };

  # This will define all the hosts exposed by the flake and designate the
  # modules and services, along with defining the hardware configuration
  # for each host.
  # <name> of each attr set will resolve to the host's hostname.
  hosts.nemesis = {
    platform = "amd";
    gpu = "nvidia";
    ephemeralRoot = true;
    boot-drive = "/dev/disk/by-id/nvme-CT2000P3SSD8_2325E6E77434";
    bootloader = "systemd-boot";
    # Enables dotfiles and desktop environment/services.
    desktop.enable = true;
    extraCfg = { };
  };
  hosts.apollo = {
    platform = "intel";
    ephemeralRoot = true;
    bootloader = "systemd-boot";
    boot-drive = "/dev/disk/by-id/nvme-eui.002538d221b47b01";
    # Public services will be exposed to the web server.
    public-services = [
      {
        name = "librechat";
        domain = "chat.bwfiq.com";
      }
      {
        name = "forgejo";
        domain = "git.rrv.sh";
      }
      {
        name = "rrv-sh";
        domain = "rrv.sh";
      }
      {
        name = "immich";
        domain = "photos.bwfiq.com";
      }
      {
        name = "aenyrathia-wiki";
        domain = "aenyrathia.wiki";
      }
    ];
    # Internal services will be exposed with tailscale only.
    internal-services = [
      "mongodb"
      "mariadb"
      "postgresql"
      "redis"
    ];
    extraCfg = { };
  };
  host.helios = {
    platform = "intel";
    boot-drive = "nvme-eui.6479a784aad00284";
    ephemeralRoot = true;
    bootloader = "systemd-boot";
    extraCfg = { };
  };
}
