{
  self,
  pkgs,
  ...
}: {
  home.sessionVariables.EDITOR = "nvim";
  home.packages = [
    self.packages.${pkgs.stdenv.system}.nvf
  ];
}
