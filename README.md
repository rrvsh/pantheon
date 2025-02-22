Uses a [one-byte .gitignore](https://drewdevault.com/2019/12/30/dotfiles.html).

Contains configuration files for NixOS. Everything is declared through [flake.nix](flake.nix) as a starting point. System-level configuration is in [configuration.nix](configuration.nix) and [hardware-configuration.nix](hardware-configuration.nix). User-specific configuration is in [home.nix](home.nix).

# TODO

v1.0.0 will be a full replacement for my Windows desktop.

What is currently missing:
- LLMs
- Stable Diffusion
- Steam and games
- IDE
- Video editing
- Photo editing
- Whatever else I think of

v0.1.0 will be adequate. The milestones to reach are:
- [ ] Set up SSH keys for GitHub and other machines
- Update home-manager so I don't have to rebuild the entire system to change configs
- Modularise the nix files
- Set up Neovim as a worthy VS Code replacement
  - terminal in bottom pane
  - filetree in right pane
  - syntax highlighting
  - ability to open two files side by side
  - git live sync (may have to implement this myself)
  - keyboard shortcuts for all the above
- rice Hyprland
  - plugins for all the desktop environment stuff

## Thoughts I have
- Hyprland from flake so I'm on the bleeding edge? Scrumptious
- Set up SSH keys from every machine to every machine ever

## Neovim Plugins
- lazy.nvim
- markview.nvim
- nvim-tree
- helpview.nvim (vimdoc viewer)
