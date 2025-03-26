{ pkgs, ... }:
{
  stylix.cursor = {
    name = "Banana";
    package = pkgs.banana-cursor;
    size = 22;
  };
}
