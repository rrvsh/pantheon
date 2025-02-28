{self, pkgs, ...}:

{
  home.packages = [
    self.packages.${pkgs.stdenv.system}.nvf
  ];
}
