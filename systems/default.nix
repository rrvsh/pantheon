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
      ./modules/boot.nix
      ./modules/networking.nix
      ./modules/nix.nix
      ./modules/programs/zsh.nix
      ./modules/security.nix
      ./modules/users.nix
    ]
    # Options for graphical systems.
    (lib.optionals (type == "desktop") [
      ./modules/hardware/audio.nix
      ./modules/hardware/bluetooth.nix
      ./modules/programs/getty.nix
      ./modules/programs/hyprland.nix
      ./modules/programs/hyprlock.nix
      ./modules/stylix.nix
    ])
    # Options for specific hostnames.
    (lib.optionals (hostname == "nemesis") [
      ./hw-nemesis.nix
      ./modules/bootloaders/systemd-boot.nix
      ./modules/hardware/cpu_amd.nix
      ./modules/hardware/nvidia.nix
    ])
  ];
}
