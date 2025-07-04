{ lib, ... }:
let
  inherit (lib)
    mapAttrsToList
    optional
    concatStrings
    flatten
    mkOption
    mapAttrs
    isString
    replicate
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
        heading = mkOption {
          type = str;
          default = "";
        };
        description = mkOption {
          type = str;
          default = "";
        };
        order = mkOption {
          type = listOf str;
          default = [ ];
        };
        parts = mkOption { type = lazyAttrsOf textType; };
      };
    })
  ];
  mkListFromAttrs =
    prefix:
    { name, value }:
    let
      sectionHeading = result: "${concatStrings (replicate prefix "#")} ${result}";
    in
    if isString value then
      [
        (sectionHeading name)
        value
      ]
    else
      # TODO: handle order being empty
      flatten [
        [
          (sectionHeading (if value.heading == "" then name else value.heading))
        ]
        (optional (value.description != "") value.description)
        (map (mkListFromAttrs (prefix + 1)) (
          if value.order == [ ] then
            mapAttrsToList (name: value: { inherit name value; }) value.parts
          else
            map (x: {
              name = x;
              value = flip getAttr value.parts x;
            }) value.order
        ))
      ];
in
{
  options.text = mkOption {
    default = { };
    type = lazyAttrsOf textType;
    apply = mapAttrs (
      name: value: concatStringsSep "\n" (flatten (mkListFromAttrs 1 { inherit name value; }))
    );
  };
  config.text.readme.parts.helpers.parts."Generating Text" =
    ''
      The option `text.<name>` supports either a string or a submodule with attributes order and parts.
      The parts attribute can either be a string, which will get concatenated in the order laid out in `text.<name>.order`, or can itself have the attributes order and parts, in which case it will be evaluated recursively.'';
}
