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
              ./modules/nix-config.nix
              ./modules/security.nix
              ./modules/users.nix
              ./modules/networking.nix
              ./modules/shell.nix
            ];
            desktopModules = [
              ./modules/graphical.nix
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
                inputs.nixos-hardware.nixosModules.gigabyte-b650
                {
                  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
                }
              ])
              ++ (lib.optionals (hostname == "mellinoe" || hostname == "apollo") [
                ./modules/bootloaders/systemd-boot.nix
                ./modules/filesystems/impermanence.nix
                ./modules/hardware/cpu_intel.nix
              ])
              ++ (lib.optionals (hostname == "orpheus") [
                inputs.nixos-hardware.nixosModules.raspberry-pi-4
                {
                  fileSystems."/" = {
                    device = "/dev/disk/by-uuid/44444444-4444-4444-8888-888888888888";
                    fsType = "ext4";
                  };
                  nixpkgs.hostPlatform = "aarch64-linux";
                }
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
        (mkSystem "headless" "orpheus" "/dev/disk/by-uuid/44444444-4444-4444-8888-888888888888")
      ];

      # Make the SD image the default build output for `nix build`
      packages.aarch64-linux.default = self.nixosConfigurations.orpheus.config.system.build.sdImage;
    };
  inputs = {
    impermanence.url = "github:nix-community/impermanence";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
    disko = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/disko/latest";
    };
    flake-utils = {
      inputs.systems.follows = "systems";
      url = "github:numtide/flake-utils";
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };
    hyprcloser = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:rrvsh/hyprcloser";
    };
    hyprshaders = {
      flake = false;
      url = "github:0x15BA88FF/hyprshaders";
    };
    nix-index-database = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nix-index-database";
    };
    nvf = {
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
      url = "github:NotAShelf/nvf";
    };
    sops-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:Mic92/sops-nix";
    };
    spicetify-nix = {
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
      url = "github:Gerg-L/spicetify-nix";
    };
    stylix = {
      inputs = {
        flake-utils.follows = "flake-utils";
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
      url = "github:danth/stylix";
    };
  };
}
