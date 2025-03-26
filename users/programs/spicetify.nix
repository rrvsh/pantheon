{
  inputs,
  pkgs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
  imports = [
    inputs.spicetify-nix.homeManagerModules.spicetify
  ];
  programs.spicetify = {
    enable = true;
    spotifyLaunchFlags = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
    windowManagerPatch = true;
    enabledCustomApps = with spicePkgs.apps; [
      marketplace
    ];
  };
}
