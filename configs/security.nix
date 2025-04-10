{ inputs, ... }:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    age.sshKeyPaths = [ "/home/rafiq/.ssh/id_ed25519" ];
    secrets = {
      "rafiq/password".neededForUsers = true;
      "services/wakapi_password_salt" = { };
      ts_auth_key = { };
      cwp_jira_link = { };
      cwp_jira_pat = { };
      gemini_api_key = { };
    };
  };

  security.sudo.wheelNeedsPassword = false;
}
