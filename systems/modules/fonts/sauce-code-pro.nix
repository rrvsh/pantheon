{pkgs, ...}: {
  fonts.packages = with pkgs; [
    nerd-fonts.sauce-code-pro
  ];
  stylix.fonts = {
    serif = {
      package = pkgs.nerd-fonts.terminess-ttf;
      name = "SauceCodePro Nerd Font";
    };
    sansSerif = {
      package = pkgs.nerd-fonts.terminess-ttf;
      name = "SauceCodePro Nerd Font";
    };
    emoji = {
      package = pkgs.nerd-fonts.terminess-ttf;
      name = "SauceCodePro Nerd Font";
    };
    monospace = {
      package = pkgs.nerd-fonts.terminess-ttf;
      name = "SauceCodePro Nerd Font Mono";
    };
    sizes = {
      applications = 16;
      desktop = 12;
      popups = 12;
      terminal = 16;
    };
  };
}
