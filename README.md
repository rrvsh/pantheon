# Planning

## To-do

- [ ] Copy over ~/.ssh/id_ed25519 and zellij status bar plugin confirmation
- [ ] Migrate immich to apollo, point to helios
- [x] Migrate LibreChat to apollo, maintain db
- [ ] Figure out wakapi
- [x] Add forgejo
- [ ] Add simple blog

## Versions

- 1.0.0
  - Setup desktop as hypervisor with nixos and win11
    - Spare drive as steam library
    - GPU passthrough to either system
    - Always running, VMs spun down except when in use
  - Apollo as hypervisor
    - VMs for docker host, home-assistant, bare metal or containerised services
  - Automated backups for home and state directories
  - Ability to build VMs of all systems and implement integration tests
    - Staging VMs for ad-hoc testing
  - All servers set up with following services:
    - Git server
    - Chat app
    - Network shares
    - Federation with ActivityPub
    - Wakapi
  - Add a way to define services per host and refer to them by hostname
  - helios as file and db server, apollo as services and reverse proxy
- 0.3.0
  - Integration tests for all services
  - Migrate services from helios

# Modules

The nixosModules and homeModules exposed by this flake are slightly out of the norm.

Option declarations for user specific configuration are kept to:

- homeModules for CLI
- nixosModules for desktop

System configurations, to this end, should include the window manager, lockscreen, terminal etc. for that system.

These desktop programs will be **configured** in home-manager for each user, but those configurations consult the osConfig variable passed in by home-manager.

# System Setup

The following files are **required** for system activation:

- /persist/home/${mainUser}/.ssh/id_ed25519

This private key will be used by sops-nix to decrypt the secrets in [this encrypted file](secrets/secrets.yaml). The secrets inside the yaml file should also be set, or otherwise removed alongside their declarations , found [here](modules/nixos/system/secrets.nix) and references.

```bash
# On the target machine
# Boot into the NixOS installer

sudo passwd

# On the host machine
deploy --user "rafiq" --ip "10.10.0.102" --hostname "apollo"
```

### From a Local NixOS Installer

The installation may run out of space when installing from an install ISO. In that case, use Disko to format the drives first, then create a `/mnt/tmp` directory and set it as TMPDIR for nixos-install.

```bash
sudo su
nix --extra-experimental-features "nix-command flakes" run github:nix-community/disko/master -- --mode destroy,format,mount --flake github:rrvsh/pantheon#<HOSTNAME>
# Copy SSH key to /persist/home/rafiq/.ssh
mkdir /mnt/tmp
TMPDIR=/mnt/tmp nixos-install --flake github:rrvsh/pantheon#<HOSTNAME> --no-root-password
reboot
```

# Impermanence

System and user state is stored under /persist. Anything not declared under
`{environment,home}.persistence` is deleted on system boot.
