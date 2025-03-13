{inputs, ...}: {
  imports = [
    inputs.stylix.nixosModules.stylix
    ./themes/catppuccin.nix
  ];
  stylix.enable = true;
}
