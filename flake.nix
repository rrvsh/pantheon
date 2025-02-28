{
  description = "NixOS setup for one host with home-manager";

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nvf,
    ...
  } @ inputs: let
    args = {inherit self inputs;};
    mkSystem = hostname:
      nixpkgs.lib.nixosSystem {
        specialArgs = args;
        modules = [
          ./systems/${hostname}.nix

          # Add the home-manager user
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              # Don't instantiate the home-manager instance of nixpkgs
              useGlobalPkgs = true;
              # Install user packages to /etc/profiles
              useUserPackages = true;
              # Pass inputs to configurations
              extraSpecialArgs = args;
              # Add the users
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
    ];
    # Packages
    packages.x86_64-linux.nvf =
      (inputs.nvf.lib.neovimConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [./packages/nvf.nix];
      })
      .neovim;
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nvf.url = "github:notashelf/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";
  };
}
