{pkgs, ...}: {
  home.packages = with pkgs; [
    fastfetch # system info
    wl-clipboard # provides cli copy and paste commands
    aichat # duh
  ];

  services = {
    # clipboard history (depends on wl-clipboard)
    cliphist.enable = true;
  };
}
