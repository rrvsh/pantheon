{ inputs, pkgs, ... }:
{
  imports = [
    inputs.stylix.nixosModules.stylix
    ./themes/darkviolet.nix
    ./fonts/sauce-code-pro.nix
    ./cursors/banana-cursor.nix
  ];
  stylix = {
    enable = true;
    image = ../../media/wallpaper.jpg;
  };
}
