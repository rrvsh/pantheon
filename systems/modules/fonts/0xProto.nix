{pkgs, ...}: {
  fonts.packages = with pkgs; [
    nerd-fonts._0xproto
  ];
  stylix.fonts = {
    serif = {
      package = pkgs.nerd-fonts.terminess-ttf;
      name = "0xProto Nerd Font";
    };
    sansSerif = {
      package = pkgs.nerd-fonts.terminess-ttf;
      name = "0xProto Nerd Font";
    };
    emoji = {
      package = pkgs.nerd-fonts.terminess-ttf;
      name = "0xProto Nerd Font";
    };
    monospace = {
      package = pkgs.nerd-fonts.terminess-ttf;
      name = "0xProto Nerd Font Mono";
    };
    sizes = {
      applications = 16;
      desktop = 12;
      popups = 12;
      terminal = 16;
    };
  };
}
