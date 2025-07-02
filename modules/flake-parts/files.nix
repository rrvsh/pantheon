{ inputs, ... }:
{
  imports = [ inputs.files.flakeModules.default ];
  perSystem = psArgs: {
    make-shells.default.packages = [ psArgs.config.files.writer.drv ];
  };
  text.readme.parts.generated-files = ''
    This flake uses the [files flake-parts module](https://flake.parts/options/files.html) to generate documentation.
    The list of generated files are:
  '';
}
