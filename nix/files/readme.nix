{ config, ... }:
{
  text.readme = {
    heading = "Pantheon";
    description = # markdown
      ''
        This flake serves as a monorepo for my systems (using IaC), dotfiles, and scripts.
        It's hosted at https://git.rrv.sh/rrvsh/pantheon, and mirrored to https://github.com/rrvsh/pantheon.
      '';
    order = [
      "Structure"
      "Acknowledgements"
    ];
    parts."Acknowledgements" = # markdown
      ''
        Thanks to the following for inspiring this configuration. I highly recommend you look through their writings and configurations.
        - [ornicar](https://github.com/ornicar/dotfiles) which is where I first heard of NixOS
        - [No Boilerplate](https://www.youtube.com/watch?v=CwfKlX3rA6E&pp=0gcJCfwAo7VqN5tD) for making me finally try the OS
        - [ryan4yin](https://nixos-and-flakes.thiscute.world/) for being an amazing introduction to NixOS, home-manager, and flakes
        - [NotAShelf](https://github.com/NotAShelf/) for their blog and for the wonderful [NVF](https://github.com/notashelf/nvf)
        - [mightyiam](https://github.com/mightyiam/infra) for their infrastructure repo using flake-parts
        - [drupol](https://not-a-number.io/2025/refactoring-my-infrastructure-as-code-configurations/) for this blog post which convinced me to rebase my infra to use flake-parts
      '';
    parts."Structure" = # markdown
      ''
        The system configurations are defined in [`flake.manifest`](nix/manifest.nix).
        `manifest.owner` provides the attributes for the administrator user, including username and pubkey.
        `manifest.hosts` provides the specifications for the system configurations that should be exposed by the flake as nixosConfigurations.
        `flake.modules.nixos.*` provide NixOS options and configurations.
        The attribute `flake.modules.nixos.default` provides options that will be applied to every system of that class.
        You can use it as seen [here](nix/modules/flake/home-manager.nix):

        ```nix
        flake.modules.nixos.default.imports = [ inputs.home-manager.nixosModules.default ];
        ```

        The other attributes under `flake.modules.nixos` should be opt-in, i.e. provide options that will be set in the profiles.
        `flake.profiles.nixos` provides profiles which use the options defined in `flake.modules.nixos` to define different roles for each system, such as graphical, laptop, headless, etc.
        Options should not be defined here.
        `flake.contracts.nixos.*` will provide contracts, such as reverse proxies or databases, which will configure options on the provider and receiver host.
      '';
  };

  perSystem =
    { pkgs, ... }:
    {
      files.files = [
        {
          path_ = "docs/README.md";
          drv = pkgs.writeText "README.md" config.text.readme;
        }
      ];
    };
}
