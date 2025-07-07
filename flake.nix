{
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (
      (inputs.import-tree ./nix)
      // {
        systems = import inputs.systems;
        flake.paths.root = ./.;
      }
    );
  inputs = {
    ### SYSTEM ###

    # systems provides a list of supported nix systems.
    systems.url = "github:nix-systems/default";
    # nixos-unstable provides a binary cache for all packages.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # impermanence provides a nice abstraction over linking files from /persist
    impermanence.url = "github:nix-community/impermanence";
    # flake-parts lets us define flake modules.
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    # disko provides declarative drive partitioning
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # sops-nix lets us version control secrets like passwords and api keys
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ### FLAKE PARTS MODULES ###

    # import-tree imports all nix files in a given directory.
    import-tree.url = "github:vic/import-tree";
    # files lets us write text files and automatically add checks for them
    files.url = "github:mightyiam/files";
    # text.nix lets us easily define markdown text to pass to files
    text.url = "github:rrvsh/text.nix";
    # make-shells.<name> creates devShells and checks
    make-shell = {
      url = "github:nicknovitski/make-shell";
      inputs.flake-compat.follows = "dedupe_flake-compat";
    };
    # git-hooks ensures nix flake check is ran before commits
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs = {
        flake-compat.follows = "dedupe_flake-compat";
        nixpkgs.follows = "nixpkgs";
        gitignore.follows = "dedupe_gitignore";
      };
    };

    ### HOME-MANAGER ###

    # home-manager manages our user packages and dotfiles
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nix-index-database indexes the nixpkgs binaries for use with comma
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # the nix user repository for mainly firefox extensions
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
    # nvf provides modules to wrap neovim
    nvf = {
      url = "github:notashelf/nvf";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        systems.follows = "systems";
        flake-utils.follows = "dedupe_flake-utils";
        mnw.follows = "dedupe_mnw";
      };
    };

    ### DEDUPE ###

    dedupe_flake-compat.url = "github:edolstra/flake-compat";
    dedupe_flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
    dedupe_mnw.url = "github:gerg-l/mnw";
    dedupe_gitignore = {
      url = "github:hercules-ci/gitignore.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
