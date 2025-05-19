{ config, pkgs, osConfig, ... }:

{
  imports = [
    ./cli.nix
    ./desktop.nix
  ];

  cli.editor = "nvf";
  cli.file-browser = "yazi";

  home.shellAliases.v = "nvim";
  home.shellAliases = {
    edit = "nvim $(fzf)";
  };

  programs.zoxide.enable = true;
  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;

  home.packages = with pkgs; [
    ripgrep
    fzf
    pantheon.rebuild
  ];
  home.persistence."/persist/home/rafiq" = {
	directories = [
	".ssh"
	".config/sops/age"
	"repos" 
        ".local/share/zoxide" 
	];
	allowOther = true;
  };

  home.stateVersion = "24.11";
}
