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
}
