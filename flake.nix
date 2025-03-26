{
  outputs =
    {
      self,
      ...
    }@inputs:
    let
      mkSystem = type: hostname: {
        name = "${hostname}";
        value =
          let
            args = {
              inherit
                self
                inputs
                type
                hostname
                ;
            };
          in
          inputs.nixpkgs.lib.nixosSystem {
            specialArgs = args;
            modules = [
              ./systems

              inputs.home-manager.nixosModules.home-manager
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
      };
    in
    {
      nixosConfigurations = builtins.listToAttrs [
        (mkSystem "desktop" "nemesis")
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
