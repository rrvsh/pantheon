{
  description = "NixOS setup for one host with home-manager";

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nvf,
    ...
  } @ inputs: {
    # System Configurations
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
         
          # Include NVF in the system
          ({ pkgs, ... }: { environment.systemPackages = [ self.packages.${pkgs.stdenv.system}.nvf ]; })
        ];
      };
    };

    # NVF Configurations
    packages.x86_64-linux.nvf = (inputs.nvf.lib.neovimConfiguration { 
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [ ( {pkgs, ...}: {} ) ]; 
    }).neovim;
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nvf.url = "github:notashelf/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs";
  };
}
