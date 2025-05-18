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
    neovim
    ripgrep
    fzf
    (pkgs.writeShellScriptBin "rebuild" # sh
    ''
    if [ ! -f "flake.nix" ]; then
    	echo "flake.nix not found in current directory. exiting..."
	exit 1
    fi

    git add . && \
    nixos-rebuild switch --flake . --use-remote-sudo && \
    git commit -a
    '')
  ];
}
