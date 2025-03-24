{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    fastfetch # system info
    wl-clipboard # provides cli copy and paste commands
    aichat # duh
    ripgrep
    devenv
    bat
    ttyper
    hyprpicker
    inputs.hyprcloser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
