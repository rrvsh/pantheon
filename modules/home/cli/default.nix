{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.cli = {
    shell = lib.pantheon.mkStrOption;
    finder = lib.pantheon.mkStrOption;
    screensaver.enable = lib.mkEnableOption "";
    screensaver.timeout = lib.pantheon.mkStrOption;
    screensaver.command = lib.pantheon.mkStrOption;
    file-browser = lib.pantheon.mkStrOption;
    multiplexer = lib.pantheon.mkStrOption;
    fetch = lib.pantheon.mkStrOption;
    git = {
      name = lib.pantheon.mkStrOption;
      email = lib.pantheon.mkStrOption;
      defaultBranch = lib.pantheon.mkStrOption;
    };
  };

  config = lib.mkMerge [
    {
      home.shell.enableShellIntegration = true;
      programs.ssh = {
        enable = true;
        extraConfig = ''
          Host *
            SetEnv TERM=xterm-256color
        '';
      };
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
    {
      programs.starship = {
        enable = true;
        settings = {
          add_newline = false;
          format = ''
            $directory$character
          '';
          right_format = ''
            $all
          '';
          git_branch.format = "[$symbol$branch(:$remote_branch)]($style) ";
          shlvl.disabled = false;
          hostname.disabled = true;
          username.disabled = true;
        };
      };
    }
  ];
}
