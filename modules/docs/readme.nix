{ config, lib, ... }:
let
  inherit (lib) singleton;
in
{
  text.readme.order = [
    "generated-files"
    "helpers"
  ];
  text.readme.parts.helpers.order = [ "text-helper" ];

  perSystem =
    { pkgs, ... }:
    {
      files.files = singleton {
        path_ = "README.md";
        drv = pkgs.writeText "README.md" config.text.readme;
      };
    };
}
