{
  description = "flake forward setup with two hosts on different architectures";

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      forEachSupportedSystem =
        f:
        nixpkgs.lib.genAttrs
          [
            "x86_64-linux"
            "aarch64-linux"
            "x86_64-darwin"
            "aarch64-darwin"
          ]
          (
            system:
            f {
              pkgs = import nixpkgs { inherit system; };
            }
          );
      args = { inherit self inputs; };
      mkSystem =
        hostname:
        nixpkgs.lib.nixosSystem {
          specialArgs = args;
          modules = [
            ./systems/${hostname}.nix

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = args;
                users.rafiq.imports = [
                  ./users/rafiq.nix
                ];
              };
            }
          ];
        };
      mkListItem = hostname: {
        name = "${hostname}";
        value = mkSystem "${hostname}";
      };
    in
    {
      # System Configurations
      nixosConfigurations = builtins.listToAttrs [
        (mkListItem "nemesis")
        (mkListItem "mellinoe")
      ];
    };

  inputs = {
    hyprland-plugins.inputs.hyprland.follows = "hyprland";
    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    wii-cursor.path = "/home/rafiq/repos/dotfiles/media/wii-cursors-xcursor";
    wii-cursor.type = "path";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko/latest";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    hyprcloser.url = "github:rrvsh/hyprcloser";
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
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    nvf.url = "github:notashelf/nvf";
    sops-nix.url = "github:Mic92/sops-nix";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    stylix.url = "github:danth/stylix";
    yazi.url = "github:sxyazi/yazi";
    astal.url = "github:aylur/astal";
    astal.inputs.nixpkgs.follows = "nixpkgs";
    ags.url = "github:aylur/ags";
    ags.inputs.nixpkgs.follows = "nixpkgs";
  };
}
