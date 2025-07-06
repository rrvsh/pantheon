# Pantheon
This flake serves as a monorepo for my systems (using IaC), dotfiles, and scripts.

## Generated Files
This flake uses the [files flake-parts module](https://flake.parts/options/files.html) to generate documentation.
The list of generated files are:
- [docs/cheatsheet.md](docs/cheatsheet.md)
- [README.md](README.md)
## Structure
The system configurations are defined in [`flake.manifest`](nix/manifest.nix).
`flake.manifest.owner` provides the attributes for the administrator user, including username and pubkey.
`flake.manifest.hosts` provides the specifications for the system configurations that should be exposed by the flake as nixosConfigurations.
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
