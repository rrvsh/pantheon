{
  pkgs,
  config,
  ...
}: {
  fonts.packages = with pkgs; [
    nerd-fonts.terminess-ttf
  ];
  stylix.fonts = {
    serif = config.stylix.fonts.monospace;
    sansSerif = config.stylix.fonts.monospace;
    emoji = config.stylix.fonts.monospace;
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
