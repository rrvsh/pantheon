{ inputs, pkgs, ... }:
{
  imports = [
    inputs.stylix.nixosModules.stylix
    ./themes/darkviolet.nix
    ./fonts/sauce-code-pro.nix
  ];
  stylix = {
    enable = true;
    image = ../../media/wallpaper.jpg;
    cursor = {
      name = "macOS dsfs";
      package = pkgs.apple-cursor;
      size = 20;
    };
  };
}
