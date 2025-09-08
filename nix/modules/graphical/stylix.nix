{ inputs, ... }:
{
  # needs to be default because the options get
  # evaluated even if graphical is set to false
  flake.modules.nixos.default =
    { pkgs, ... }:
    {
      imports = [ inputs.stylix.nixosModules.stylix ];
      stylix.enable = true;
      stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    };
  flake.modules.darwin.default =
    { pkgs, config, ... }:
    {
      imports = [ inputs.stylix.darwinModules.stylix ];
      stylix.enable = true;
      #TODO: move into manifest
      stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
      stylix.fonts = {
        monospace.package = pkgs.jetbrains-mono;
        monospace.name = "JetBrainsMono Nerd Font";
        serif = config.stylix.fonts.monospace;
        sansSerif = config.stylix.fonts.monospace;
        emoji = config.stylix.fonts.monospace;
      };
    };
}
