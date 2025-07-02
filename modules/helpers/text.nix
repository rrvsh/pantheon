{ lib, ... }:
let
  inherit (lib)
    mkOption
    mapAttrs
    isString
    pipe
    flip
    getAttr
    concatStringsSep
    ;
  inherit (lib.types)
    lazyAttrsOf
    oneOf
    submodule
    str
    listOf
    ;
  textType = oneOf [
    str
    (submodule {
      options = {
        order = mkOption { type = listOf str; };
        parts = mkOption { type = lazyAttrsOf textType; };
      };
    })
  ];
  recurseAttrs =
    value:
    if isString value then
      value
    else
      # TODO: handle order being empty
      # TODO: add headings for each part with possible option to disable
      pipe value.order [
        (map (flip getAttr value.parts))
        (map recurseAttrs)
        (concatStringsSep "\n")
      ];
in
{
  options.text = mkOption {
    default = { };
    type = lazyAttrsOf textType;
    apply = mapAttrs (_: recurseAttrs);
  };
  config.text.readme.parts.helpers.parts.text-helper =
    "The option `text.<name> supports either a string or a submodule with attributes order and parts. The parts attribute can either be a string, which will get concatenated in the order laid out in `text.<name>.order`, or can itself have the attributes order and parts, in which case it will be evaluated recursively.";
}
