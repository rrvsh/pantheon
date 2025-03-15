{inputs, ...}: {
  imports = [
    inputs.spicetify-nix.homeManagerModules.spicetify
  ];
  programs.spicetify = {
    enable = true;
    # spotifyPackage = pkgs.spotify;
    # spotifywmPackage = pkgs.spotifywm;
  };
}
