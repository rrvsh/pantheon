{ inputs, ... }:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    secrets = {
      password.neededForUsers = true;
      ts_auth_key = { };
      cwp_jira_link = { };
      cwp_jira_pat = { };
      gemini_api_key = { };
    };
  };

  security.sudo.wheelNeedsPassword = false;
}
