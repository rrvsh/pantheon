{ pkgs, ... }:
{
  stylix.fonts = {
    # packages = [ pkgs.nerd-fonts.sauce-code-pro ];
    emoji.name = "SauceCodePro Nerd Font";
    emoji.package = pkgs.nerd-fonts.sauce-code-pro;
    monospace.name = "SauceCodePro Nerd Font Mono";
    monospace.package = pkgs.nerd-fonts.sauce-code-pro;
    sansSerif.name = "SauceCodePro Nerd Font";
    sansSerif.package = pkgs.nerd-fonts.sauce-code-pro;
    serif.name = "SauceCodePro Nerd Font";
    serif.package = pkgs.nerd-fonts.sauce-code-pro;

    sizes = {
      applications = 16;
      desktop = 12;
      popups = 12;
      terminal = 16;
    };
  };
}
