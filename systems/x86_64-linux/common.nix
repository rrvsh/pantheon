{ pkgs, ... }:
{
  mainUser = {
    name = "rafiq";
    publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILdsZyY3gu8IGB8MzMnLdh+ClDxQQ2RYG9rkeetIKq8n";
    email = "rafiq@rrv.sh";
    shell = pkgs.fish;
  };
  server.mountHelios = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/atelier-cave.yaml";
  programs.fish.enable = true;
  programs.nix-ld.enable = true;
}
