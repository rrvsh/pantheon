{ pkgs, ... }:
{
  imports = [
    ./scripts
    ./comma.nix
    ./direnv.nix
    ./editorconfig.nix
    ./fzf.nix
    ./git.nix
    ./nh.nix
    ./nvf.nix
    ./starship.nix
    ./tealdeer.nix
    ./yazi.nix
    ./zellij.nix
    ./zoxide.nix
    ./zsh.nix
  ];

  home-manager.users.rafiq.home = {
    shell.enableShellIntegration = true;
    shellAliases = {
      gs = "git status";
      ai = "aichat -r %shell% -e";
      cd = "z";
      list-all-packages = "nix-store --query --requisites /run/current-system | cut -d- -f2- | sort | uniq";
    };

    packages = with pkgs; [
      aichat
      bat
      btop # add settings as home-manager module
      devenv
      fastfetch
      ripgrep
      ttyper
    ];
  };
}
