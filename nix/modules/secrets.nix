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
in
{
  flake.modules.nixos.default =
    { config, ... }:
    {
      imports = [ inputs.sops-nix.nixosModules.sops ];
      config.sops.age.sshKeyPaths = [
        "/persist${config.users.defaultUserHome}/${username}/.ssh/id_ed25519"
      ];
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
