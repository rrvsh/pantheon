{pkgs, ...}: {
  # TODO: Move wayland-specific stuff to a wayland config

  home.packages = with pkgs; [
    fastfetch # system info
    wl-clipboard # provides cli copy and paste commands
    aichat # duh
  ];

  programs = {
    # man page summaries (activate with tldr <command>)
    tealdeer = {
      enable = true;
      enableAutoUpdates = true;
    };
  };

  services = {
    # clipboard history (depends on wl-clipboard)
    cliphist.enable = true;
  };
}
