{inputs, ...}: {
  imports = [inputs.sops-nix.nixosModules.sops];
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    age.sshKeyPaths = [
      "/home/rafiq/.ssh/id_ed25519"
      "/home/rafiq/.ssh/rafiq-master"
    ];
    secrets = {
      hashed_password_rafiq = {
        neededForUsers = true;
      };
    };
  };
}
