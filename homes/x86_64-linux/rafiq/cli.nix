{ config, lib, pkgs, osConfig, ... }:
{
  imports = [
    ./programs/git.nix
    ./programs/zsh.nix
  ];
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

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.shellAliases = {
    edit = "nvim $(fzf)";
  };

  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;
}
