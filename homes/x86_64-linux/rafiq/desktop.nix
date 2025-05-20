{pkgs,...}:
{
imports = [
    ./desktop/firefox.nix
];
  home.packages = with pkgs; [
	  kitty
  ];
  home.sessionVariables = {
    TERMINAL = "kitty";
    BROWSER = "firefox";
  };
}
