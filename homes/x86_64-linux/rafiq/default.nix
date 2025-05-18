{ config, pkgs, osConfig, ... }:

{
  imports = [
    ./programs/hyprland.nix
    ./cli.nix
  ];

  home.packages = with pkgs; [
	  kitty
  ];
  home.sessionVariables = {
    TERMINAL = "kitty";
    BROWSER = ", firefox";
  };

  home.persistence."/persist/home/rafiq" = {
	directories = [
	".ssh"
	"repos"
	];
	allowOther = true;
  };

  home.stateVersion = "24.11";
}
