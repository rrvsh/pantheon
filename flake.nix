{
  outputs =
    {
      self,
      ...
    }@inputs:
    let
      mkSystem = type: hostname: bootDisk: {
        name = "${hostname}";
        value =
          let
            args = {
              inherit
                self
                inputs
                type
                hostname
                bootDisk
                ;
            };
            inherit (inputs.nixpkgs) lib;
            commonModules = [
              ./modules/boot.nix
              ./modules/bootloaders/systemd-boot.nix
              ./modules/networking.nix
              ./modules/nix-config.nix
              ./modules/security.nix
              ./modules/shell.nix
              ./modules/users.nix
            ];
            graphicalModules = [
              ./modules/graphical.nix
            ];
          in
          inputs.nixpkgs.lib.nixosSystem {
            specialArgs = args;
            modules =
              commonModules
              ++ lib.optionals (type == "graphical") graphicalModules
              ++
                # Options for specific hostnames.
                (lib.optionals (hostname == "nemesis") [
                  ./modules/filesystems/hw-nemesis.nix
                  ./modules/hardware/cpu_amd.nix
                  ./modules/hardware/nvidia.nix
                ])
              ++ (lib.optionals (hostname == "mellinoe") [
                ./modules/filesystems/impermanence.nix
                ./modules/hardware/cpu_intel.nix
              ])
              ++ (lib.optionals (hostname == "apollo") [
                ./modules/filesystems/impermanence.nix
                ./modules/hardware/cpu_intel.nix
              ]);
          };
      };
    in
    {
      nixosConfigurations = builtins.listToAttrs [
        (mkSystem "graphical" "nemesis"
          "nvme-nvme.c0a9-323332354536453737343334-435432303030503353534438-00000001"
        )
        (mkSystem "graphical" "mellinoe" "/dev/disk/by-id/nvme-eui.01000000000000008ce38e04019a68ab")
        (mkSystem "headless" "apollo" "/dev/disk/by-id/nvme-eui.002538d221b47b01")
      ];
    };
  inputs = {
    ags.inputs.nixpkgs.follows = "nixpkgs";
    ags.url = "github:aylur/ags";
    astal.inputs.nixpkgs.follows = "nixpkgs";
    astal.url = "github:aylur/astal";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko/latest";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    hyprcloser.url = "github:rrvsh/hyprcloser";
    hyprland-plugins.inputs.hyprland.follows = "hyprland";
    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprlock.url = "github:hyprwm/hyprlock";
    hyprshaders.flake = false;
    hyprshaders.url = "github:0x15BA88FF/hyprshaders";
    impermanence.url = "github:nix-community/impermanence";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nixd.url = "github:nix-community/nixd";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";
    sops-nix.url = "github:Mic92/sops-nix";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    stylix.url = "github:danth/stylix";
    yazi.url = "github:sxyazi/yazi";
  };
}
