> "This is fucking brilliant. Nobody needs this, nobody has a real use for this and this definitely does not attract girls. Still, I'll try this and probably love it. -Tim Goeree"

# As Yet Unreproducible

- [x] ~User passwords~ -> _Managed with sops-nix_
- [ ] Spotify login
- [ ] Firefox login

# Adding Secrets with sops-nix

Secrets are stored in secrets/secrets.yaml. You can edit these secrets with `sops secrets/secrets.yaml` given you have an age private key stored at `~/.config/sops/age/keys.txt`.

To decrypt these secrets with sops-nix during a rebuild, you must add your host public key to the `.sops.yaml` file. Generate it with `cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age`, add it to the file, then run `sops updatekeys secrets/secrets.yaml`.

# Acknowledgements

- https://www.youtube.com/watch?v=CwfKlX3rA6E for piquing my interest in this OS in the first place
- https://nixos-and-flakes.thiscute.world/ for teaching me about nix, nixos, flakes, and home-manager in an extremely easy to follow and well-documented fashion
- https://blog.notashelf.dev/posts/2025-02-24-ssh-signing-commits.html for teaching me how to trivially sign my commits
- https://www.reddit.com/r/NixOS/comments/fsummx/comment/fm3jbcm/ for an easy way to list all installed packages (`nix-store --query --requisites /run/current-system | cut -d- -f2- | sort | uniq`)
