{ config, lib, pkgs, osConfig, ... }:
{
  imports = [
    ./cli/git.nix
    ./cli/zsh.nix
  ];

}
