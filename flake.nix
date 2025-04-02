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
              ./modules/networking.nix
              ./modules/nix-config.nix
              ./modules/security.nix
              ./modules/users.nix
            ];
            desktopModules = [
              ./modules/graphical.nix
              ./modules/shell.nix
            ];
          in
          inputs.nixpkgs.lib.nixosSystem {
            specialArgs = args;
            modules =
              commonModules
              ++ lib.optionals (type == "desktop") desktopModules
              # Options for specific hostnames.
              ++ (lib.optionals (hostname == "nemesis") [
                ./modules/bootloaders/systemd-boot.nix
                ./modules/filesystems/hw-nemesis.nix
                ./modules/hardware/cpu_amd.nix
                ./modules/hardware/nvidia.nix
              ])
              ++ (lib.optionals (hostname == "mellinoe" || hostname == "apollo") [
                ./modules/bootloaders/systemd-boot.nix
                ./modules/filesystems/impermanence.nix
                ./modules/hardware/cpu_intel.nix
              ]);
          };
      };
    in
    {
      nixosConfigurations = builtins.listToAttrs [
        (mkSystem "desktop" "nemesis"
          "nvme-nvme.c0a9-323332354536453737343334-435432303030503353534438-00000001"
        )
        (mkSystem "desktop" "mellinoe" "/dev/disk/by-id/nvme-eui.01000000000000008ce38e04019a68ab")
        (mkSystem "headless" "apollo" "/dev/disk/by-id/nvme-eui.002538d221b47b01")
      ];
    };
  inputs = {
    disko.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko/latest";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    hyprcloser.url = "github:rrvsh/hyprcloser";
    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    hyprshaders.flake = false;
    hyprshaders.url = "github:0x15BA88FF/hyprshaders";
    impermanence.url = "github:nix-community/impermanence";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvf.url = "github:rrvsh/nvf/fix/pylsp-pkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    stylix.url = "github:danth/stylix";
  };
}
