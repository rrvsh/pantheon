{ lib, config, ... }:
let
  inherit (builtins) concatStringsSep;
  inherit (lib.lists) singleton;
in
{
  text.cheatsheet = concatStringsSep "\n" [
    "`__curPos.file` will give the full evaluated path of the nix file it is called in. See [this issue](https://github.com/NixOS/nix/issues/5897#issuecomment-1012165198) for more information."
  ];
  perSystem =
    { pkgs, ... }:
    {
      files.files = singleton {
        path_ = "docs/cheatsheet.md";
        drv = pkgs.writeText "cheatsheet.md" config.text.cheatsheet;
      };
    };
}
