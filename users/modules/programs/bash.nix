{
  programs.bash = {
    enable = true;
    shellAliases = {
      gs = "git status";
      ai = "aichat -r %shell% -e";
    };
  };
}
