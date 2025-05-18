{ config, pkgs, osConfig, ... }:

{
  imports = [
    ./cli.nix
    ./desktop.nix
  ];

  home.persistence."/persist/home/rafiq" = {
	directories = [
	".ssh"
	".config/sops/age"
	"repos"
	];
	allowOther = true;
  };

  home.stateVersion = "24.11";
}
