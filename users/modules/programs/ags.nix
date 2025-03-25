{ inputs, pkgs, ... }:
{
  imports = [ inputs.ags.homeManagerModules.default ];

  # Expose the cli tools to the home environment
  home.packages = [ inputs.ags.packages.${pkgs.stdenv.hostPlatform.system}.io ];

  programs.ags = {
    enable = true;
    configDir = ./ags; # ~/.config/ags
    systemd.enable = false;

    # The module only includes the core astal3, astal4 and astal-io libraries
    extraPackages = with pkgs; [
      # add packages to runtime
      # inputs.ags.packages.${pkgs.system}.battery
      # fzf
    ];
  };
}
