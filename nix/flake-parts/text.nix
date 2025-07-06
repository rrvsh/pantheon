{ inputs, ... }:
{
  imports = [ inputs.text.flakeModules.default ];
}
