{ pkgs, ... }:
{
  home-manager.users.rafiq = {
    home.shellAliases = {
      ai = "aichat -r %shell% -e";
    };

    home.packages = with pkgs; [
      aichat
    ];

    xdg.configFile."aichat/config.yaml" = {
      text = ''
        model: gemini:gemini-2.0-flash
        clients:
        - type: gemini
      '';
    };
  };

}
