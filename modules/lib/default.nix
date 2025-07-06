{
  lib,
  config,
  inputs,
  ...
}:
let
  inherit (lib.trivial) pipe;
  inherit (lib.strings) removePrefix hasPrefix;
  inherit (lib.attrsets) concatMapAttrs mapAttrs' filterAttrs;
  mkSystem =
    prefix: name: value:
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
          config.flake.profiles.nixos.common
          (value.extraCfg or { })
        ] ++ (value.profiles or [ ]);
      };
    };
in
{
  flake.lib = {
    flattenAttrs = attrset: concatMapAttrs (_: v: v) attrset;
    extractConfigurations =
      prefix: hosts:
      pipe hosts [
        (filterAttrs (name: _: hasPrefix prefix name))
        (mapAttrs' (mkSystem prefix))
      ];
  };
}
