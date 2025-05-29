{ lib, config, ... }:
{
  sops = {
    defaultSopsFile = lib.snowfall.fs.get-file "secrets/secrets.yaml";
    age.sshKeyPaths = [ "/persist/home/rafiq/.ssh/id_ed25519" ];
    secrets = {
      "keys/tailscale" = { };
      "keys/gemini" = { };
      "keys/cvt-jira" = { };
      "keys/cloudflare" = { };
      "keys/telegram_bot" = { };
      "misc/cvt-jira-link" = { };
      "rafiq/hashedPassword".neededForUsers = true;
      "librechat/creds_key" = { };
      "librechat/creds_iv" = { };
      "librechat/jwt_secret" = { };
      "librechat/jwt_refresh_secret" = { };
      "librechat/meili_master_key" = { };
    };
  };
  environment.shellInit = # sh
    ''
      export GEMINI_API_KEY=$(sudo cat ${config.sops.secrets."keys/gemini".path})
      export CVT_JIRA_KEY=$(sudo cat ${config.sops.secrets."keys/cvt-jira".path})
      export CVT_JIRA_LINK=$(sudo cat ${config.sops.secrets."misc/cvt-jira-link".path})
      export CREDS_KEY=$(sudo cat ${config.sops.secrets."librechat/creds_key".path})
      export CREDS_IV=$(sudo cat ${config.sops.secrets."librechat/creds_iv".path})
      export JWT_SECRET=$(sudo cat ${config.sops.secrets."librechat/jwt_secret".path})
      export JWT_REFRESH_SECRET=$(sudo cat ${config.sops.secrets."librechat/jwt_refresh_secret".path})
      export MEILI_MASTER_KEY=$(sudo cat ${config.sops.secrets."librechat/meili_master_key".path})
    '';
}
