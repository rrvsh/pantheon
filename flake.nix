{
  description = "flake forward setup with two hosts on different architectures";

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    # args will later be used in outputs to inherit the flake and its inputs for use in modules.
    args = {inherit self inputs;};
    # mkSystem lets us repeat the same config for multiple systems, called later in outputs.
    mkSystem = hostname:
      nixpkgs.lib.nixosSystem {
        specialArgs = args;
        modules = [
          ./systems/${hostname}.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true; # inherit the nixpkgs and its config
              useUserPackages = true;
              extraSpecialArgs = args;
              users.rafiq.imports = [
                ./users/rafiq.nix
              ];
            };
          }
        ];
      };
  in {
    # System Configurations
    nixosConfigurations = builtins.listToAttrs [
      {
        name = "nemesis";
        value = mkSystem "nemesis";
      }
      {
        name = "orpheus";
        value = mkSystem "orpheus";
      }
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    yazi.url = "github:sxyazi/yazi";
    nvf.url = "github:notashelf/nvf";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    nixd.url = "github:nix-community/nixd";
    stylix.url = "github:danth/stylix";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    sops-nix.url = "github:Mic92/sops-nix";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };
}
