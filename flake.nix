{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    snowfall-lib.url = "github:snowfallorg/lib";
    snowfall-lib.inputs.nixpkgs.follows = "nixpkgs";
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = inputs: 
	 inputs.snowfall-lib.mkFlake {
		inherit inputs;
		src = ./.;
		snowfall.namespace = "pantheon";
		systems.modules.nixos = with inputs; [
			disko.nixosModules.disko
			impermanence.nixosModules.impermanence
		];
	 };
}
