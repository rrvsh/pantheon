{
  programs.bash = {
    enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake";
      gs = "git status";
      ai = "aichat -r %shell% -e";
    };
  };
}
