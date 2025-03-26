{
  stylix.cursor = {
    name = "wii-cursor";
    # package = inputs.wii-cursor.packages.${pkgs.stdenv.hostPlatform.system}.wii-cursor;
    package = builtins.trace (inputs.wii-cursor.packages.${pkgs.stdenv.hostPlatform.system}.wii-cursor
    ) (inputs.wii-cursor.packages.${pkgs.stdenv.hostPlatform.system}.wii-cursor);
    size = 20;
  };
}
