{ inputs, username, ... }:
let
  opacity = 0.8;
  toImport = [
    ./themes/cursors/banana-cursor.nix
    ./themes/colourschemes/darkviolet.nix
    ./themes/fonts/sauce-code-pro.nix
    {
      # Put options that exist in both NixOS and home-manager modules here.
      stylix = {
        enable = true;
        image = ../../media/wallpaper.jpg;
        opacity = {
          applications = opacity;
          desktop = opacity;
          popups = opacity;
          terminal = opacity;
        };
      };
    }
  ];
in
{
  # Enable basic fonts for reasonable Unicode coverage
  fonts.enableDefaultPackages = true;

  imports = [ inputs.stylix.nixosModules.stylix ] ++ toImport;
  home-manager.users.${username}.imports = [ inputs.stylix.homeManagerModules.stylix ] ++ toImport;

  # Put options that only exist in the NixOS module here.
  stylix.homeManagerIntegration.autoImport = false;
  stylix.homeManagerIntegration.followSystem = false;

  # Put options that only exist in the home-manager module here.
  # home-manager.users.${username}.stylix = {};
}
