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
          The system configurations are defined in [`flake.manifest`](nix/manifest.nix).
          The attribute `flake.modules.nixos.common` provides options that will be applied to every system.
        You can use it as seen [here](nix/modules/flake/home-manager.nix):

        ```nix
        flake.modules.nixos.common.imports = [ inputs.home-manager.nixosModules.default ];
        ```
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
