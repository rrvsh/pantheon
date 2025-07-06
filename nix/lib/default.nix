{
  lib,
  config,
  inputs,
  ...
}:
let
  cfg = config.flake;
  inherit (lib.trivial) pipe;
  inherit (lib.strings) removePrefix hasPrefix;
  inherit (lib.attrsets)
    concatMapAttrs
    mapAttrs'
    filterAttrs
    mergeAttrsList
    ;
in
{
  flake.lib = rec {
    flattenAttrs = attrset: concatMapAttrs (_: v: v) attrset;
    mkSystem =
      prefix: name: value:
      let
        hostName = removePrefix prefix name;
        hostConfig = value;
        flakeConfig = config;
        mkProfileCfg =
          profileList: # List of attrsets of nixos configs
          pipe profileList [
            (map flattenAttrs) # List of nixos configs
            mergeAttrsList
          ];
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
            (flattenAttrs cfg.modules.nixos)
            (mkProfileCfg (value.profiles or [ ]))
            (value.extraCfg or { })
          ];
        };
      };
    extractConfigurations =
      prefix: hosts:
      pipe hosts [
        (filterAttrs (name: _: hasPrefix prefix name))
        (mapAttrs' (mkSystem prefix))
      ];
  };
}
