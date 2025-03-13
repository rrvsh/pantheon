{
  pkgs,
  config,
  ...
}: {
  fonts.packages = with pkgs; [
    nerd-fonts.terminess-ttf
  ];
  stylix.fonts = {
    serif = {
      package = pkgs.nerd-fonts.terminess-ttf;
      name = "Terminess Nerd Font";
    };
    sansSerif = {
      package = pkgs.nerd-fonts.terminess-ttf;
      name = "Terminess Nerd Font";
    };
    emoji = {
      package = pkgs.nerd-fonts.terminess-ttf;
      name = "Terminess Nerd Font";
    };
    monospace = {
      package = pkgs.nerd-fonts.terminess-ttf;
      name = "Terminess Nerd Font Mono";
    };
    sizes = {
      applications = 16;
      desktop = 12;
      popups = 12;
      terminal = 16;
    };
  };
}
