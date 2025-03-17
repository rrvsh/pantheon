{inputs, ...}: {
  imports = [
    inputs.stylix.nixosModules.stylix
    ./themes/catppuccin.nix
    ./fonts/sauce-code-pro.nix
  ];
  stylix.enable = true;
}
