Uses a [one-byte .gitignore](https://drewdevault.com/2019/12/30/dotfiles.html).

Contains configuration files for NixOS. Everything is declared through [[flake.nix]] as a starting point. System-level configuration is in [[configuration.nix]] and [[hardware-configuration.nix]]. User-specific configuration is in [[home.nix]].

# TODO

- Set up Neovim as a worthy VS Code replacement
  - terminal in bottom pane
  - filetree in right pane
  - syntax highlighting
  - ability to open two files side by side
  - keyboard shortcuts for all the above
- rice Hyprland
  - plugins for all the desktop environment stuff
