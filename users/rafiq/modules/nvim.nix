{ config, lib, ... }: let
  nvimPath = "${config.home.homeDirectory}/repos/dotfiles/users/rafiq/.config/nvim";
in {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink nvimPath;
}
