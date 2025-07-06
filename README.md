# Pantheon
This flake serves as a monorepo for my systems (using IaC), dotfiles, and scripts.

## Generated Files
This flake uses the [files flake-parts module](https://flake.parts/options/files.html) to generate documentation.
The list of generated files are:
- [docs/cheatsheet.md](docs/cheatsheet.md)
- [README.md](README.md)
## Structure
  The system configurations are defined in [`flake.manifest`](nix/manifest.nix).
  The attribute `flake.modules.nixos.common` provides options that will be applied to every system.
You can use it as seen [here](nix/modules/flake/home-manager.nix):

```nix
flake.modules.nixos.common.imports = [ inputs.home-manager.nixosModules.default ];
```
