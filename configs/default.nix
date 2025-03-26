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
      ./programs/zsh.nix
      ./security.nix
      ./users.nix
    ]
    # Options for graphical systems.
    (lib.optionals (type == "desktop") [
      ./hardware/audio.nix
      ./hardware/bluetooth.nix
      ./programs/getty.nix
      ./programs/hyprland.nix
      ./programs/hyprlock.nix
      ./stylix.nix
    ])
    # Options for specific hostnames.
    (lib.optionals (hostname == "nemesis") [
      ./hw-nemesis.nix
      ./bootloaders/systemd-boot.nix
      ./hardware/cpu_amd.nix
      ./hardware/nvidia.nix
    ])
  ];
}
