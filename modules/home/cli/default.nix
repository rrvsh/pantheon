{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.cli = {
    shell = lib.pantheon.mkStrOption;
    editor = lib.pantheon.mkStrOption;
    file-browser = lib.pantheon.mkStrOption;
    multiplexer = lib.pantheon.mkStrOption;
    git = {
      name = lib.pantheon.mkStrOption;
      email = lib.pantheon.mkStrOption;
      defaultBranch = lib.pantheon.mkStrOption;
    };
  };

  config = lib.mkMerge [
    {
      home.shell.enableShellIntegration = true;
      programs.zoxide.enable = true;
      home.shellAliases.cd = "z";
      home.persistence."/persist/home/${config.snowfallorg.user.name}".directories = [
        ".local/share/zoxide"
      ];
    }
    {
      programs.nix-index.enable = true;
      programs.nix-index-database.comma.enable = true;
    }
    {
      home.shellAliases.ai = "aichat -r %shell% -e";

      home.packages = with pkgs; [ aichat ];

      xdg.configFile."aichat/config.yaml".text = ''
        model: gemini:gemini-2.0-flash
        clients:
        - type: gemini
      '';
    }
  ];
}
