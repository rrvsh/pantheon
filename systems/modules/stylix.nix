{ inputs, ... }:
{
  imports = [
    inputs.stylix.nixosModules.stylix
    ./themes/bright.nix
    ./fonts/sauce-code-pro.nix
  ];
  stylix.enable = true;
}
