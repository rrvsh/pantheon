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
    '';
}
