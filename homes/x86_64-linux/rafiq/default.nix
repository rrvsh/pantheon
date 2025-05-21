{
  pkgs,
  inputs,
  ...
}:
{
  cli.shell = "zsh";
  cli.screensaver.enable = true;
  cli.screensaver.timeout = "10";
  cli.editor = "nvf";
  cli.file-browser = "yazi";
  cli.multiplexer = "zellij";
  cli.fetch = "hyfetch";
  cli.git.name = "Mohammad Rafiq";
  cli.git.email = "rafiq@rrv.sh";
  cli.git.defaultBranch = "prime";

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

  home.persistence."/persist/home/rafiq".directories = [ "repos" ];

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
    nh.enable = true;
  };

}
