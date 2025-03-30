{
  inputs,
  lib,
  hostname,
  type,
  modulesPath,
  ...
}:
{
  imports = builtins.concatLists [
    # Common options for all machines.
    [
      (modulesPath + "/installer/scan/not-detected.nix")
      ./boot.nix
      ./bootloaders/systemd-boot.nix
      ./networking.nix
      ./nix-config.nix
      ./security.nix
      ./shell.nix
      ./users.nix
    ]
    # Options for graphical systems.
    (lib.optionals (type == "desktop") [
      ./graphical.nix
    ])
    # Options for specific hostnames.
    (lib.optionals (hostname == "nemesis") [
      ./filesystems/hw-nemesis.nix
      # (import ./filesystems/impermanence.nix {
      #   inherit inputs lib;
      #   device = "nvme-nvme.c0a9-323332354536453737343334-435432303030503353534438-00000001";
      # })
      ./hardware/cpu_amd.nix
      ./hardware/nvidia.nix
    ])
    (lib.optionals (hostname == "mellinoe") [
      (import ./filesystems/impermanence.nix {
        inherit inputs lib;
        device = "/dev/disk/by-id/nvme-eui.01000000000000008ce38e04019a68ab";
      })
      ./hardware/cpu_intel.nix
    ])
    (lib.optionals (hostname == "apollo") [
      (import ./filesystems/impermanence.nix {
        inherit inputs lib;
        device = "/dev/disk/by-id/nvme-eui.002538d221b47b01";
      })
      ./hardware/cpu_intel.nix
    ])
  ];
}
