{ inputs, pkgs, ... }: {
  programs.yazi = {
    enable = true;
    package = inputs.yazi.packages.${pkgs.system}.default;
    enableBashIntegration = true;
    settings = {};
    theme = builtins.fromTOML (builtins.readFile ./yazi/theme.toml);
  };
}
