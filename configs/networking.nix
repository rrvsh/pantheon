{
  hostname,
  lib,
  config,
  ...
}:
{
  systemd.services.NetworkManager-dispatcher.serviceConfig = {
    ProtectClock = true; # Prevents the service from changing the system time or timezone.
    ProtectKernelTunables = true; # Restricts the service's ability to modify kernel parameters via sysctl.
    ProtectKernelModules = true; # Prevents the service from loading or unloading kernel modules.
    ProtectKernelLogs = true; # Prevents the service from reading kernel logs directly.
    SystemCallFilter = "~@clock @cpu-emulation @debug @obsolete @module @mount @raw-io @reboot @swap"; # Whitelists system calls, blocking all others based on specified groups.
    ProtectControlGroups = true; # Prevents the service from joining or modifying control groups other than its own.
    RestrictNamespaces = true; # Enforces stricter namespace isolation, preventing user namespace creation/joining.
    LockPersonality = true; # Disables the `personality()` system call, preventing execution domain changes.
    MemoryDenyWriteExecute = true; # Prevents the service from mapping memory pages as both writable and executable (W^X).
    RestrictRealtime = true; # Prevents the service from using real-time scheduling policies.
    RestrictSUIDSGID = true; # Prevents the service from utilizing setuid/setgid functionality.
  };

  systemd.services.NetworkManager.serviceConfig = {
    ProtectClock = true; # Prevents the service from changing the system time or timezone.
    ProtectKernelTunables = true; # Restricts the service's ability to modify kernel parameters via sysctl.
    ProtectKernelModules = true; # Prevents the service from loading or unloading kernel modules.
    ProtectKernelLogs = true; # Prevents the service from reading kernel logs directly.
    SystemCallFilter = "~@clock @cpu-emulation @debug @obsolete @module @mount @raw-io @reboot @swap"; # Whitelists system calls, blocking all others based on specified groups.
    ProtectControlGroups = true; # Prevents the service from joining or modifying control groups other than its own.
    RestrictNamespaces = true; # Enforces stricter namespace isolation, preventing user namespace creation/joining.
    LockPersonality = true; # Disables the `personality()` system call, preventing execution domain changes.
    MemoryDenyWriteExecute = true; # Prevents the service from mapping memory pages as both writable and executable (W^X).
    RestrictRealtime = true; # Prevents the service from using real-time scheduling policies.
    RestrictSUIDSGID = true; # Prevents the service from utilizing setuid/setgid functionality.
  };

  networking = {
    hostName = hostname;
    useDHCP = lib.mkDefault true;
    networkmanager.enable = true;
    networkmanager.wifi.backend = "iwd";

    # Configures a simple stateful firewall.
    # By default, it doesn't allow any incoming connections.
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22 # SSH
        5353 # spotifyd
      ];
      allowedUDPPorts = [
        5353 # spotifyd
      ];
    };

    interfaces.enp12s0.wakeOnLan.policy = [
      "phy"
      "unicast"
      "multicast"
      "broadcast"
      "arp"
      "magic"
      "secureon"
    ];
    interfaces.enp12s0.wakeOnLan.enable = true;
  };
  services.openssh = {
    enable = true;
    settings.PrintMotd = true;
  };
  services.tailscale = {
    enable = true;
    authKeyFile = config.sops.secrets.ts_auth_key.path;
  };
}
