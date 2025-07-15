{ inputs, ... }:
{
  imports = [ inputs.manifest.flakeModules.default ];
}
