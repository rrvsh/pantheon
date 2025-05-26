# Planning

## To-do

- [ ] Implement an status bar for the desktop configuration
- [ ] Copy over ~/.ssh/id_ed25519 and zellij status bar plugin confirmation

## Versions

- 1.0.0
  - Replicate old zagreus wholly
  - Automated backups for home and state directories
  - Ability to build VMs of all systems and implement integration tests
    - Staging VMs for ad-hoc testing
  - All servers set up with following services:
    - Git server
    - Chat app
    - Network shares
    - Federation with ActivityPub
    - Wakapi
- 0.2.0
  - Provision Apollo
  - Fix all NVF errors

# Modules

The nixosModules and homeModules exposed by this flake are slightly out of the
norm.

Option declarations for user specific configuration are kept to:

- homeModules for CLI
- nixosModules for desktop

System configurations, to this end, should include the window manager,
lockscreen, terminal etc. for that system.

These desktop programs will be **configured** in home-manager for each user, but
those configurations consult the osConfig variable passed in by home-manager.

# System Setup

The following files are **required** for system activation:

- /persist/home/${mainUser}/.ssh/id_ed25519

This private key will be used by sops-nix to decrypt the secrets in
[[secrets/secrets.yaml]]. The secrets inside the yaml file should also be set,
or otherwise removed alongside their declarations (in
[[modules/nixos/system/secrets.nix]]) and references.

# Impermanence

System and user state is stored under /persist. Anything not declared under
`{environment,home}.persistence` is deleted on system boot.
