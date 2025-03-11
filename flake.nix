{
  description = "NixOS setup for one host with home-manager";

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

          # Add the home-manager user
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
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";

    yazi.url = "github:sxyazi/yazi";

    nvf.url = "github:notashelf/nvf";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url  = "github:danth/stylix";
  };
}
