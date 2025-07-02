{
  inputs,
  withSystem,
  lib,
  config,
  ...
}:
let
  inherit (builtins) map head;
  inherit (lib) concatStringsSep;
  #TODO: add the .nix file its generated from
  mkListEntry = x: "- [" + x.path_ + "](" + x.path_ + ")";
  listOfGeneratedFiles = withSystem (head config.systems) (psArgs: psArgs.config.files.files);
in
{
  imports = [ inputs.files.flakeModules.default ];
  perSystem = psArgs: {
    make-shells.default.packages = [ psArgs.config.files.writer.drv ];
  };
  text.readme.parts.generated-files = concatStringsSep "\n" (
    [
      "This flake uses the [files flake-parts module](https://flake.parts/options/files.html) to generate documentation."

      "The list of generated files are:"

    ]
    ++ (map mkListEntry listOfGeneratedFiles)
  );
}
