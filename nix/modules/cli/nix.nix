{
  flake.modules.nixos.default.nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
