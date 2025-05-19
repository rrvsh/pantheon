{config, lib, osConfig, ... }:
{
  imports = [
    ./file-browser/yazi.nix
  ];

  options.cli =	{
    editor = lib.pantheon.mkStrOption;
    file-browser = lib.pantheon.mkStrOption;
  };

  config = {

  };
}
