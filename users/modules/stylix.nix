{ inputs, pkgs, ... }:
{
  imports = [
    inputs.stylix.homeManagerModules.stylix
    ../../themes/darkviolet.nix
    ../../themes/fonts/sauce-code-pro.nix
    ../../themes/cursors/banana-cursor.nix
  ];
  stylix = {
    enable = true;
    image = ../../media/wallpaper.jpg;
  };
  stylix.targets.gtk.extraCss = ''

  '';
}
