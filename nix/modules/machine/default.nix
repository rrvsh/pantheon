{
  flake.modules.nixos.default =
    { modulesPath, ... }:
    {
      imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
    };
}
