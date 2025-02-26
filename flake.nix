{
  description = "NixOS setup for one host with home-manager";

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: {
    nixosConfigurations = {
      nemesis = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [ 
          ./hosts/nemesis 
          
          # Add the home-manager user
          home-manager.nixosModules.home-manager {
            # Don't instantiate the home-manager instance of nixpkgs
            home-manager.useGlobalPkgs = true;
            # Install user packages to /etc/profiles
            home-manager.useUserPackages = true;
            # Pass inputs to home-manager configurations
            home-manager.extraSpecialArgs = { inherit inputs; };
            # Add the users
            home-manager.users.rafiq.imports = [
              ./users/rafiq
            ];
          }
        ];
      };
    };
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
}
