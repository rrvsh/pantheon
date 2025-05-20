{config, lib, osConfig, ... }:
{
  imports = [
    ./file-browser/yazi.nix
    ./editor/nvf.nix
    ./shell/zsh.nix
    ./utilities/git.nix
  ];

  options.cli =	{
    shell = lib.pantheon.mkStrOption;
    editor = lib.pantheon.mkStrOption;
    file-browser = lib.pantheon.mkStrOption;
  };

  config = {

  };
}
