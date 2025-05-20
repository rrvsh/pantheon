{config, lib, osConfig, ... }:
{
  options.cli =	{
    shell = lib.pantheon.mkStrOption;
    editor = lib.pantheon.mkStrOption;
    file-browser = lib.pantheon.mkStrOption;
git = {
    name = lib.pantheon.mkStrOption;
    email = lib.pantheon.mkStrOption;
    defaultBranch = lib.pantheon.mkStrOption;
  };
  };
}
