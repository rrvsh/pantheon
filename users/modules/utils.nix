{ pkgs, ... }:
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
  ];

  services = {
    # clipboard history (depends on wl-clipboard)
    cliphist.enable = true;
  };
}
