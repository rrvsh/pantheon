# Default shell utilities and programs
{
  imports = [
    ./programs/bash.nix
    ./programs/direnv.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/nvim.nix
    ./programs/starship.nix
    ./programs/tealdeer.nix
    ./programs/tmux.nix
    ./programs/yazi.nix
    ./scripts
  ];
}
