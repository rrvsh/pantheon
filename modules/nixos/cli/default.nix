{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ];

  options.cli = { };

  config = lib.mkMerge [
    {
      programs.zsh.enable = true;
      users.defaultUserShell = pkgs.zsh;
      environment.pathsToLink = [ "/share/zsh" ]; # enables completion
    }
  ];
}
