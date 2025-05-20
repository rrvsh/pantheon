{
  pkgs,
  inputs,
  ...
}:
{
  cli.shell = "zsh";
  cli.editor = "nvf";
  cli.file-browser = "yazi";
  cli.multiplexer = "zellij";
  cli.git.name = "Mohammad Rafiq";
  cli.git.email = "rafiq@rrv.sh";
  cli.git.defaultBranch = "prime";
  desktop.windowManager = "hyprland";
  desktop.browser = "firefox";
  desktop.terminal = "kitty";

  home.shellAliases = {
    v = "nvim";
  };

  home.packages = with pkgs; [
    ripgrep
    devenv
    pantheon.rebuild
    pantheon.edit
    inputs.nixspect.packages."x86_64-linux".nixspect
  ];

  home.persistence."/persist/home/rafiq".directories = [
    "repos"
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs = {
    thefuck.enable = true;
    tealdeer.enable = true;
    tealdeer.settings.updates.auto_update = true;
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };

}
