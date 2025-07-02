{
  users.rafiq = {
    primary = true;
    email = "rafiq@rrv.sh";
    alternate-emails = [
      "mohammadrafiq@rrv.sh" # Work
      "googaabumtum@gmail.com" # Old Personal
      "mohammadrafiq567@gmail.com" # Old Work
    ];
    pubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILdsZyY3gu8IGB8MzMnLdh+ClDxQQ2RYG9rkeetIKq8n";
  };

  # Services will use this to find where their configuration
  # should point to and the providers will set up the needed
  # configuration for each service.
  providers = {
    reverse-proxy = {
      type = "nginx";
      host = "apollo";
    };
    mongodb.host = "helios";
  };

  # This will define all the hosts exposed by the flake and designate the
  # modules and services, along with defining the hardware configuration
  # for each host.
  # <name> of each attr set will resolve to the host's hostname.
  # Hosts can reach each other through their hostname (using Tailscale)
  hosts.nemesis = {
    machine = {
      localIP = "10.10.0.11"; # Set up a static IP
      platform = "amd"; # Set up CPU microcode etc
      gpu = "nvidia"; # Set up nvidia drivers etc
      # Partitioning and formatting config using disko
      boot-drive = "/dev/disk/by-id/nvme-CT2000P3SSD8_2325E6E77434";
    };
    # Profiles will define configuration, such as graphical
    # setting up window managers and web browsers
    profiles = [
      "graphical"
      "desktop" # might be a no-op?
    ];
    services = [
      {
        type = "stable-diffusion";
        public = false; # false by default
        port = 7860;
      }
    ];
    # extraCfg will be added directly to the system's config
    extraCfg = {
      programs.steam.enable = true;
    };
  };

  hosts.apollo = {
    machine = {
      localIP = "10.10.0.102";
      platform = "intel";
      boot-drive = "/dev/disk/by-id/nvme-eui.002538d221b47b01";
    };
    profiles = [
      "server" # no-op as servers shouldnt have extra config but might change
    ];
    services = [
      {
        type = "librechat"; # Picks up the mongodb and nginx automatically
        public = true;
        port = 1234;
        domain = "chat.bwfiq.com";
      }
    ];
  };

  hosts.helios = {
    machine = {
      localIP = "10.10.0.101";
      platform = "intel";
      boot-drive = "nvme-eui.6479a784aad00284";
    };
    profiles = [ "server" ];
    # Sets up network shares of the configured type under a folder
    # e.g. /shares/{rafiqmedia, tv-shows}
    # These are then consumed on other hosts under /mnt/{hostname}/{rafiqmedia,tv-shows}
    shares = [
      {
        folder = "rafiqmedia";
        type = [
          "nfs"
          "smb"
        ];
      }
    ];
  };

  hosts.iris = {
    machine = {
      localIP = "10.10.0.12";
      platform = "apple-silicon";
      boot-drive = "";
    };
    profiles = [
      "graphical"
      "macbook" # asahi linux config etc - may not be needed
      "laptop" # primarily power management
    ];
  };
}
