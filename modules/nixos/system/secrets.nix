{ config, lib, ... }:
{
  sops = {
    defaultSopsFile = lib.snowfall.fs.get-file "secrets/secrets.yaml";
    age.sshKeyPaths = ["/persist/home/rafiq/.ssh/id_ed25519"];
    secrets ={
      "rafiq/hashedPassword".neededForUsers = true;
    };
  };
}
