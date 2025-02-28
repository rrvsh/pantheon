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
  in {
    # System Configurations
    nixosConfigurations = {
      nemesis = nixpkgs.lib.nixosSystem {
        specialArgs = args;
        modules = [
          ./systems/nemesis.nix

          # Add the home-manager user
          home-manager.nixosModules.home-manager
          {
            # Don't instantiate the home-manager instance of nixpkgs
            home-manager.useGlobalPkgs = true;
            # Install user packages to /etc/profiles
            home-manager.useUserPackages = true;
            # Pass inputs to home-manager configurations
            home-manager.extraSpecialArgs = args;
            # Add the users
            home-manager.users.rafiq.imports = [
              ./users/rafiq.nix
            ];
          }
        ];
      };
    };

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
