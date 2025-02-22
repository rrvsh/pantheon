# automatically called by flake.nix
{ config, pkgs, lib, ... }:

{
  imports = [
    ./configuration.nix
  ];
}
