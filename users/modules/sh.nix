# Default shell utilities and programs
{
  imports = [
    ./programs/btop.nix
    ./programs/direnv.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/nvf.nix
    ./programs/starship.nix
    ./programs/tealdeer.nix
    ./programs/tmux.nix
    ./programs/yazi.nix
    ./programs/zsh.nix
    ./scripts
  ];
  home.shell.enableShellIntegration = true;
  home.shellAliases = {
    gs = "git status";
    ai = "aichat -r %shell% -e";
  };
  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        indent_style = "space";
        indent_size = 2;
        trim_trailing_whitespace = true;
        insert_final_newline = false;
      };
    };
  };
}
