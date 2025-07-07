{
  inputs = {
    # nixos-unstable provides a binary cache for all packages.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # systems provides a list of supported nix systems.
    systems.url = "github:nix-systems/default";
    # flake-parts lets us define flake modules.
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    # home-manager manages our user packages and dotfiles
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # disko provides declarative drive partitioning
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # impermanence provides a nice abstraction over linking files from /persist
    impermanence.url = "github:nix-community/impermanence";
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

    # The following are not used but are here for deduplication.
    dedupe_flake-compat.url = "github:edolstra/flake-compat";
    dedupe_gitignore = {
      url = "github:hercules-ci/gitignore.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (
      (inputs.import-tree ./nix)
      // {
        systems = import inputs.systems;
      }
    );
}
