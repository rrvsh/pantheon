{ config, lib, ... }:
let
  inherit (lib) singleton;
in
{
  text.readme = {
    heading = "Pantheon";
    description = ''
      This flake serves as a monorepo for my systems (using IaC), dotfiles, and scripts.
    '';
    parts.helpers = {
      heading = "Helpers";
      description = "The following are some helpers for the repo as a whole.";
    };
  };

  perSystem =
    { pkgs, ... }:
    {
      files.files = singleton {
        path_ = "README.md";
        drv = pkgs.writeText "README.md" config.text.readme;
      };
    };
}
