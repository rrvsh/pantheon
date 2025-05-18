{config, lib,...}:
{
imports = [];

options.cli = {};

config = lib.mkMerge [
{
programs.zsh.enable = true;
environment.pathsToLink = ["/share/zsh"];
}
];
}
