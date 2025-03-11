{
  description = "flake forward setup with two hosts on different architectures";

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    args = {inherit self inputs;};
    mkSystem = hostname:
      nixpkgs.lib.nixosSystem {
        specialArgs = args;
        modules = [
          ./systems/${hostname}.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
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
        value = nixpkgs.lib.nixosSystem {
          specialArgs = args;
          modules = [
            inputs.nixos-hardware.nixosModules.raspberry-pi-4
            "${nixpkgs}/nixos/modules/profiles/minimal.nix"
            ./systems/orpheus.nix

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                extraSpecialArgs = args;
                users.rafiq.imports = [
                  ./users/rafiq.nix
                ];
              };
            }
          ];
        };
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
  };
}
