{
  lib,
  inputs,
  config,
  ...
}:
let
  inherit (lib) mkOption;
  inherit (config.flake.lib.options) mkStrOption;
  inherit (lib.types)
    listOf
    str
    coercedTo
    submodule
    ;
  permOpts = {
    user = mkStrOption "root";
    group = mkStrOption "root";
    mode = mkStrOption "0755";
  };
  mkOpts =
    type: opts:
    mkOption {
      default = [ ];
      type = listOf (
        coercedTo str (d: { ${type} = d; }) (submodule {
          options = {
            ${type} = mkStrOption "";
          } // opts;
        })
      );
    };
in
{
  flake.modules.nixos.default =
    { config, ... }:
    {
      imports = [ inputs.impermanence.nixosModules.impermanence ];
      options.persistDirs = mkOpts "directory" permOpts;
      options.persistFiles = mkOpts "file" { parentDirectory = permOpts; };
      config = {
        programs.fuse.userAllowOther = true;
        fileSystems."/persist".neededForBoot = true;
        environment.persistence."/persist" = {
          hideMounts = true;
          directories = config.persistDirs;
          files = config.persistFiles;
        };
      };
    };
}
