{ config, pkgs, osConfig, ... }:

{
  cli.shell = "zsh";
  cli.editor = "nvf";
  cli.file-browser = "yazi";
  cli.git.name = "Mohammad Rafiq";
  cli.git.email = "rafiq@rrv.sh";
  cli.git.defaultBranch = "prime";
 desktop.windowManager = "hyprland";
 desktop.browser = "firefox";
 desktop.terminal = "kitty";

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
    devenv
    pantheon.rebuild
  ];

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

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
