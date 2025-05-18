{pkgs,...}:
{
imports = [
    ./desktop/hyprland.nix
];
  home.packages = with pkgs; [
	  kitty
  ];
  home.sessionVariables = {
    TERMINAL = "kitty";
    BROWSER = "firefox";
  };

}
