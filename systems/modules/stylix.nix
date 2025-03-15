{inputs, ...}: {
  imports = [
    inputs.stylix.nixosModules.stylix
    ./themes/catppuccin.nix
    ./fonts/terminess.nix
  ];
  stylix.enable = true;
}
