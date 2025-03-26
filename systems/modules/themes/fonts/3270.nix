{pkgs, ...}: {
  fonts.packages = with pkgs; [
    nerd-fonts._3270
  ];
  stylix.fonts = {
    serif = {
      package = pkgs.nerd-fonts.terminess-ttf;
      name = "3270 Nerd Font";
    };
    sansSerif = {
      package = pkgs.nerd-fonts.terminess-ttf;
      name = "3270 Nerd Font";
    };
    emoji = {
      package = pkgs.nerd-fonts.terminess-ttf;
      name = "3270 Nerd Font";
    };
    monospace = {
      package = pkgs.nerd-fonts.terminess-ttf;
      name = "3270 Nerd Font Mono";
    };
    sizes = {
      applications = 16;
      desktop = 12;
      popups = 12;
      terminal = 16;
    };
  };
}
