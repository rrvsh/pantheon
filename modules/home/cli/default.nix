{config, lib, osConfig, ... }:
{
  imports = [
    ./file-browser/yazi.nix
    ./editor/nvf.nix
    ./utilities/git.nix
  ];

  options.cli =	{
    editor = lib.pantheon.mkStrOption;
    file-browser = lib.pantheon.mkStrOption;
  };

  config = {

  };
}
