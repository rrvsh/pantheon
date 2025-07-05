{ inputs, ... }:
{
  imports = [ inputs.git-hooks.flakeModule ];
  perSystem = psArgs: {
    pre-commit.settings.hooks = {
      # Nix Linters
      deadnix.enable = true;
      statix.enable = true;
      nil.enable = true;
      nixfmt-rfc-style.enable = true;
      # Flake Health Checks
      flake-checker.enable = true;
      # Misc
      mixed-line-endings.enable = true;
      trim-trailing-whitespace.enable = true;
      #TODO: figure out vale
      #TODO: make nix develop work
      #TODO: add nix flake check
      #TODO: add write-files
    };
    make-shells.default.shellHook = psArgs.config.pre-commit.installationScript;
  };
}
