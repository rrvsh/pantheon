{ lib, ... }:
let
  inherit (lib) mkOption singleton;
  inherit (lib.types)
    int
    str
    port
    path
    attrs
    ;
  inherit (lib.strings) splitString;
  inherit (builtins) length concatStringsSep tail;
in
rec {
  # Helpers
  splitDomain = domain: splitString "." domain;
  shortenList =
    count: list:
    let
      len = length list;
    in
    if len <= count then list else (shortenList count (tail list));

  # Modules
  mkAttrOption = mkOption {
    type = attrs;
    default = { };
  };
  mkIntOption =
    default:
    mkOption {
      type = int;
      inherit default;
    };
  mkStrOption = mkOption {
    type = str;
    default = "";
  };
  mkPortOption =
    default:
    mkOption {
      type = port;
      inherit default;
    };
  mkPathOption =
    default:
    mkOption {
      type = path;
      inherit default;
    };

  # Domains
  isRootDomain = domain: length (splitDomain domain) <= 2;
  mkRootDomain = domain: concatStringsSep "." (shortenList 2 (splitDomain domain));
  mkWildcardDomain = rootDomain: concatStringsSep "." ((singleton "*") ++ (splitDomain rootDomain));
  mkHost = domain: if isRootDomain domain then domain else mkWildcardDomain (mkRootDomain domain);
}
