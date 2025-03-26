{
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
      ./networking.nix
      ./nix-config.nix
      ./security.nix
      ./users.nix
    ]
    # Options for graphical systems.
    (lib.optionals (type == "desktop") [
      ./hardware/audio.nix
      ./hardware/bluetooth.nix
      ./stylix.nix
    ])
    # Options for specific hostnames.
    (lib.optionals (hostname == "nemesis") [
      ./bootloaders/systemd-boot.nix
      ./filesystems/hw-nemesis.nix
      ./hardware/cpu_amd.nix
      ./hardware/nvidia.nix
    ])
  ];
}
