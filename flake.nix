{
  outputs =
    inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;
      snowfall.namespace = "pantheon";
    };
  inputs = {
    crane.url = "github:ipetkov/crane";
    rrv-sh.url = "github:rrvsh/rrv.sh";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko";
    flake-compat.url = "github:edolstra/flake-compat";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-utils-plus.inputs.flake-utils.follows = "flake-utils";
    flake-utils-plus.url = "github:gytis-ivaskevicius/flake-utils-plus";
    flake-utils.inputs.systems.follows = "systems";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    hyprland.url = "github:hyprwm/Hyprland";
    impermanence.url = "github:nix-community/impermanence";
    import-tree.url = "github:vic/import-tree";
    mnw.url = "github:Gerg-L/mnw";
    nil.inputs.nixpkgs.follows = "nixpkgs";
    nil.url = "github:oxalica/nil";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.inputs.flake-parts.follows = "flake-parts";
    nur.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
    nvf.inputs.flake-parts.follows = "flake-parts";
    nvf.inputs.flake-utils.follows = "flake-utils";
    nvf.inputs.mnw.follows = "mnw";
    nvf.inputs.nil.follows = "nil";
    nvf.inputs.nixpkgs.follows = "nixpkgs";
    nvf.inputs.systems.follows = "systems";
    nvf.url = "github:rrvsh/nvf/uv-nvim";
    python-flexseal.inputs.flake-utils.follows = "flake-utils";
    python-flexseal.inputs.nixpkgs.follows = "nixpkgs";
    python-flexseal.url = "github:Janrupf/python-flexseal";
    rrvsh-nixpkgs.url = "github:rrvsh/nixpkgs/librechat-module";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";
    rust-overlay.url = "github:oxalica/rust-overlay";
    snowfall-lib.inputs.flake-compat.follows = "flake-compat";
    snowfall-lib.inputs.flake-utils-plus.follows = "flake-utils-plus";
    snowfall-lib.inputs.nixpkgs.follows = "nixpkgs";
    snowfall-lib.url = "github:snowfallorg/lib";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    stable-diffusion-webui-nix.inputs.flake-utils.follows = "flake-utils";
    stable-diffusion-webui-nix.inputs.nixpkgs.follows = "nixpkgs";
    stable-diffusion-webui-nix.inputs.python-flexseal.follows = "python-flexseal";
    stable-diffusion-webui-nix.url = "github:janrupf/stable-diffusion-webui-nix";
    stylix.url = "github:nix-community/stylix";
    systems.url = "github:nix-systems/default";
    zjstatus.inputs.crane.follows = "crane";
    zjstatus.inputs.flake-utils.follows = "flake-utils";
    zjstatus.inputs.nixpkgs.follows = "nixpkgs";
    zjstatus.inputs.rust-overlay.follows = "rust-overlay";
    zjstatus.url = "github:dj95/zjstatus";
  };
}
