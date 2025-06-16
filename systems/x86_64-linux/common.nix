{ pkgs, ... }:
let
  inherit (pkgs) zsh;
in
{
  mainUser = {
    name = "rafiq";
    publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILdsZyY3gu8IGB8MzMnLdh+ClDxQQ2RYG9rkeetIKq8n";
    email = "rafiq@rrv.sh";
  };
  server.mountHelios = true;

  users.defaultUserShell = zsh;
  programs = {
    zsh.enable = true;
    zsh.enableCompletion = true;
  };

  nixpkgs.hostPlatform = "x86_64-linux";
}
