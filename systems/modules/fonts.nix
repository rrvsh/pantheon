{ pkgs, ... }: {
  # Enable basic fonts for reasonable Unicode coverage
  fonts.enableDefaultPackages = true;

  fonts.packages = with pkgs; [
    nerd-fonts.terminess-ttf 
  ];
}
