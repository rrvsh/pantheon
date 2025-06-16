{ lib, ... }:
let
  inherit (lib) singleton;
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
  mkAttrOption = lib.mkOption {
    type = lib.types.attrs;
    default = { };
  };
  mkStrOption = lib.mkOption {
    type = lib.types.str;
    default = "";
  };
  mkPortOption =
    port:
    lib.mkOption {
      type = lib.types.port;
      default = port;
    };
  mkPathOption =
    path:
    lib.mkOption {
      type = lib.types.path;
      default = path;
    };

  # Domains
  isRootDomain = domain: length (splitDomain domain) <= 2;
  mkRootDomain = domain: concatStringsSep "." (shortenList 2 (splitDomain domain));
  mkWildcardDomain = rootDomain: concatStringsSep "." ((singleton "*") ++ (splitDomain rootDomain));
  mkHost = domain: if isRootDomain domain then domain else mkWildcardDomain (mkRootDomain domain);
}
