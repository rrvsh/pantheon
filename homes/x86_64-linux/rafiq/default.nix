{ pkgs, inputs, ... }:
{
  cli = {
    shell = "zsh";
    finder = "fzf";
    screensaver.enable = true;
    screensaver.timeout = "100";
    screensaver.command = "cbonsai -S -w 0.1 -L 40 -M 2 -b 2";
    editor = "nvf";
    file-browser = "yazi";
    multiplexer = "zellij";
    fetch = "hyfetch";
    git.name = "Mohammad Rafiq";
    git.email = "rafiq@rrv.sh";
    git.defaultBranch = "prime";
  };
  home = {
    shellAliases = {
      v = "nvim";
      e = "edit";
    };

    packages = with pkgs; [
      cbonsai
      ripgrep
      devenv
      pantheon.rebuild
      pantheon.edit
      inputs.nixspect.packages."x86_64-linux".nixspect
    ];

    persistence."/persist/home/rafiq".directories = [ "repos" ];
  };
  programs = {
    nh.enable = true;
    thefuck.enable = true;
    tealdeer.enable = true;
    tealdeer.settings.updates.auto_update = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
