{ inputs, ... }:
{
  debug = true;
  imports = [
    inputs.make-shell.flakeModules.default
    inputs.manifest.flakeModules.default
    inputs.flake-parts.flakeModules.modules
    inputs.text.flakeModules.default
  ];
}
