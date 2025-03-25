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
    iconTheme = {
      enable = true;
      package = pkgs.numix-icon-theme;
      dark = "Numix";
      light = "Numix-Light";
    };
    opacity = {
      applications = 0.8;
      desktop = 0.8;
      popups = 0.8;
      terminal = 0.8;
    };
    targets.gtk.extraCss = # css
      ''
        window {
            background-image: linear-gradient(to bottom, rgba(0, 0, 0, 0) 50%, rgba(0, 0, 0, 0.1) 50%);
            background-size: 100% 2px;  /* Adjust height for scanline thickness */
              background-color: rgba(0, 0, 0, 0.05); /*Very slight transparency*/
        }
        entry {
          box-shadow: inset 1px 1px 2px rgba(0, 0, 0, 0.2);
        }
        button:hover {
          box-shadow: 0 0 5px rgba(0, 255, 0, 0.5);  /* Replace color */
        }
      '';
  };
}
