{ inputs, ... }:
{
  imports = [
    inputs.stylix.nixosModules.stylix
    ./themes/darkviolet.nix
    ./fonts/sauce-code-pro.nix
  ];
  stylix.enable = true;
}
