{
  flake.modules.nixos.default.nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  flake.modules.darwin.default = {
    nix.enable = false;
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
