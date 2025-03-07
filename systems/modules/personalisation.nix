{ inputs, pkgs, config, ... }: {
  imports = [ inputs.stylix.nixosModules.stylix ];
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    fonts = {
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
  };
}
