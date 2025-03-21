{ inputs, ... }:
{
  imports = [
    inputs.stylix.nixosModules.stylix
    ./themes/black-metal.nix
    ./fonts/sauce-code-pro.nix
  ];
  stylix.enable = true;
}
