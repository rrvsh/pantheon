{ config, lib, pkgs, osConfig, ... }:
{
  imports = [
    ./cli/git.nix
    ./cli/zsh.nix
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.shellAliases = {
    edit = "nvim $(fzf)";
  };

  programs.zoxide.enable = true;
  home.persistence."/persist/home/rafiq".directories = [ ".local/share/zoxide" ];
  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;

  home.packages = with pkgs; [
    ripgrep
    fzf
    pantheon.rebuild
  ];
}
