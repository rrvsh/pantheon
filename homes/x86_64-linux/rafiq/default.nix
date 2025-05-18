{ config, pkgs, osConfig, ... }:

{
  imports = [
    ./programs/git.nix
    ./programs/hyprland.nix
  ];

  home.stateVersion = "24.11";

  home.file = {
  };

  home.packages = with pkgs; [
    neovim
    ripgrep
    kitty
    (pkgs.writeShellScriptBin "rebuild" # sh
    ''
    if [ ! -f "flake.nix" ]; then
    	echo "flake.nix not found in current directory. exiting..."
	exit 1
    fi

    git add .
    nixos-rebuild switch --flake . --use-remote-sudo
    git commit -a
    '')
  ];
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.persistence."/persist/home/rafiq" = {
directories = [
".ssh"
"repos"
];
allowOther = true;
  };
}
