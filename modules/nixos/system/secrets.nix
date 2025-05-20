{ lib, config, ... }:
{
  sops = {
    defaultSopsFile = lib.snowfall.fs.get-file "secrets/secrets.yaml";
    age.sshKeyPaths = [ "/persist/home/rafiq/.ssh/id_ed25519" ];
    secrets = {
      "keys/tailscale" = { };
      "keys/gemini" = { };
      "rafiq/hashedPassword".neededForUsers = true;
    };
  };
  environment.shellInit = # sh
    ''
      export GEMINI_API_KEY=$(sudo cat ${config.sops.secrets."keys/gemini".path})
    '';
}
