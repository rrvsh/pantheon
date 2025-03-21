{ inputs, ... }:
{
  imports = [
    inputs.stylix.nixosModules.stylix
    ./themes/3024.nix
    ./fonts/sauce-code-pro.nix
  ];
  stylix.enable = true;
}
