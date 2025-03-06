{ pkgs, ... }: {
  # Enable basic fonts for reasonable Unicode coverage
  fonts.enableDefaultPackages = true;

  fonts.packages = with pkgs; [
    terminus-nerdfont
  ];
}
