{ config, lib, ... }:
{
  sops = {
    defaultSopsFile = lib.snowfall.fs.get-file "secrets/secrets.yaml";
    age.sshKeyPaths = [ "/persist/home/rafiq/.ssh/id_ed25519" ];
    secrets = {
      "keys/tailscale" = { };
      "rafiq/hashedPassword".neededForUsers = true;
    };
  };
}
