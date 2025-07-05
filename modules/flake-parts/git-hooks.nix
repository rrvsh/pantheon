{ inputs, ... }:
{
  # TODO: add to readme
  imports = [ inputs.git-hooks.flakeModule ];
  perSystem = psArgs: {
    pre-commit.settings.hooks = {
      nixpkgs-fmt.enable = true;
      #TODO: add write-files
    };
    make-shells.default.shellHook = psArgs.config.pre-commit.installationScript;
  };
}
