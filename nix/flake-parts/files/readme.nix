{ config, ... }:
{
  text.readme = {
    heading = "Pantheon";
    description = # markdown
      ''
        This flake serves as a monorepo for my systems (using IaC), dotfiles, and scripts.
      '';
    parts."Structure" = # markdown
      ''
        The system configurations are defined in [`flake.hostSpec`](nix/hostSpec.nix).
      '';
  };

  perSystem =
    { pkgs, ... }:
    {
      files.files = [
        {
          path_ = "README.md";
          drv = pkgs.writeText "README.md" config.text.readme;
        }
      ];
    };
}
