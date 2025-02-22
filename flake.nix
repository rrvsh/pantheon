{
  description = "a minimal NixOS config using flake and home-manager";
  
  # Declare dependencies
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { 
    self, 
    nixpkgs, 
    home-manager, 
    ...
  }: {
    nixosConfigurations = {
      hekate = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/hekate

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            
            home-manager.users.rafiq = import ./users/rafiq/home.nix;
          }
        ];
      };
    };
  };
}
