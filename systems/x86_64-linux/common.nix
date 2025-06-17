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
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/atelier-cave.yaml";
  users.defaultUserShell = zsh;
  programs = {
    zsh.enable = true;
    zsh.enableCompletion = true;
  };
}
