{
  # TODO: use flake-parts and remove snowfall-lib
  outputs =
    inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;
      snowfall.namespace = "pantheon";
    };
  inputs = {
    # We use nixos-unstable as everything is cached.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # My fork for random shit
    rrvsh-nixpkgs.url = "github:rrvsh/nixpkgs/librechat-module";

    # import-tree lets us use less imports = []
    import-tree.url = "github:vic/import-tree";

    # The following are used for less boilerplate.
    flake-parts.url = "github:hercules-ci/flake-parts";
    #TODO: remove snowfall
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Various nix things
    nur.url = "github:nix-community/NUR";
    sops-nix.url = "github:Mic92/sops-nix";
    disko.url = "github:nix-community/disko";
    home-manager.url = "github:nix-community/home-manager";
    impermanence.url = "github:nix-community/impermanence";
    nix-index-database.url = "github:nix-community/nix-index-database";
    stylix.url = "github:nix-community/stylix";
    systems.url = "github:nix-systems/default";

    # Packages and services that we don't use nixpkgs for.
    rrv-sh.url = "github:rrvsh/rrv.sh";
    nvf.url = "github:rrvsh/nvf/uv-nvim";
    stable-diffusion-webui-nix.url = "github:janrupf/stable-diffusion-webui-nix";
    zjstatus.url = "github:dj95/zjstatus";
  };
}
