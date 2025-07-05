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
  prefix = "nixos/";
  hosts = config.flake.hostSpec.hosts or { };
  mkSystem =
    name: value:
    let
      hostName = removePrefix prefix name;
    in
    {
      name = hostName;
      value = lib.nixosSystem {
        specialArgs = { inherit inputs hostName; };
        #TODO: add profiles system
        modules = [
          config.flake.profiles.nixos.common
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
