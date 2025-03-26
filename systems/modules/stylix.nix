{ inputs, ... }:
let
  toImport = [
    ../../themes/cursors/banana-cursor.nix
    ../../themes/darkviolet.nix
    ../../themes/fonts/sauce-code-pro.nix
  ];
in
{
  imports = [ inputs.stylix.nixosModules.stylix ] ++ toImport;

  # Enable basic fonts for reasonable Unicode coverage
  fonts.enableDefaultPackages = true;

  stylix = {
    enable = true;
    image = ../../media/wallpaper.jpg;
    homeManagerIntegration.autoImport = false;
    homeManagerIntegration.followSystem = false;
  };
}
