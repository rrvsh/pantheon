{pkgs, ...}: {
  home.packages = with pkgs; [
    fastfetch # system info
    wl-clipboard # provides cli copy and paste commands
    aichat # duh
    ripgrep
    ueberzugpp # image rendering backend for the terminal
  ];

  services = {
    # clipboard history (depends on wl-clipboard)
    cliphist.enable = true;
  };
}
