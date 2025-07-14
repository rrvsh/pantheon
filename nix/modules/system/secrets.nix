{
  config,
  inputs,
  lib,
  ...
}:
let
  cfg = config.flake;
  inherit (builtins) readFile;
  inherit (lib.meta) getExe;
  inherit (lib.strings) trim;
  inherit (cfg.admin) username pubkey;
  inherit (cfg.paths) secrets;
in
{
  flake.modules = {
    nixos.default =
      { config, ... }:
      {
        imports = [ inputs.sops-nix.nixosModules.sops ];
        config = {
          sops = {
            age.sshKeyPaths = [
              "/persist${config.users.defaultUserHome}/${username}/.ssh/id_ed25519"
            ];
            secrets."keys/gemini".sopsFile = secrets + "/keys.yaml";
          };
          environment.shellInit = # sh
            ''
              export GEMINI_API_KEY=$(sudo cat ${config.sops.secrets."keys/gemini".path})
            '';
        };
      };
    darwin.default =
      { config, ... }:
      {
        imports = [ inputs.sops-nix.darwinModules.sops ];
        config = {
          sops = {
            age.sshKeyPaths = [ "${config.users.users.${username}.home}/.ssh/id_ed25519" ];
            secrets."keys/gemini".sopsFile = secrets + "/keys.yaml";
          };
          environment.shellInit = # sh
            ''
              export GEMINI_API_KEY=$(sudo cat ${config.sops.secrets."keys/gemini".path})
            '';
        };
      };
    homeManager.default.persistDirs = [ ".config/sops/age" ];
  };
  perSystem =
    { pkgs, ... }:
    {
      files.files = [
        {
          path_ = ".sops.yaml";
          drv =
            pkgs.writeText ".sops.yaml" # yaml
              ''
                keys:
                  - &${username} ${trim (
                    readFile "${
                      pkgs.runCommand "" { } ''
                        mkdir $out; echo ${pubkey} | ${getExe pkgs.ssh-to-age} > $out/agepubkey
                      ''
                    }/agepubkey"
                  )}
                creation_rules:
                  - path_regex: \.(yaml)$
                    key_groups:
                    - age:
                      - *${username}
              '';
        }
      ];
    };
}
