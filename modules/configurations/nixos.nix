{
  config,
  lib,
  inputs,
  ...
}:
let
  inherit (lib.trivial) pipe;
  inherit (lib.attrsets) filterAttrs mapAttrs';
  inherit (lib.strings) removePrefix hasPrefix;
  cfg = config.flake;
  prefix = "nixos/";
  hosts = cfg.hostSpec.hosts or { };
  mkSystem =
    name: value:
    let
      hostName = removePrefix prefix name;
      hostConfig = value;
      flakeConfig = config;
    in
    {
      name = hostName;
      value = lib.nixosSystem {
        specialArgs = {
          inherit
            inputs
            hostName
            hostConfig
            flakeConfig
            ;
        };
        modules = [
          cfg.profiles.nixos.common
          (value.extraCfg or { })
        ] ++ (value.profiles or [ ]);
      };
    };
in
{
  flake.nixosConfigurations = pipe hosts [
    (filterAttrs (name: _: hasPrefix prefix name))
    (mapAttrs' mkSystem)
  ];
}
