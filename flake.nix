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
          in
          inputs.nixpkgs.lib.nixosSystem {
            specialArgs = args;
            modules = [
              ./modules/nixos
              ./modules/hm
              ./hosts/common.nix
              ./hosts/${hostname}.nix
            ];
          };
      };
    in
    {
      nixosConfigurations = builtins.listToAttrs [
        (mkSystem "graphical" "nemesis"
          "nvme-nvme.c0a9-323332354536453737343334-435432303030503353534438-00000001"
        )
        (mkSystem "headless" "apollo" "/dev/disk/by-id/nvme-eui.002538d221b47b01")
      ];
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
    nix-gaming = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:fufexan/nix-gaming";
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
