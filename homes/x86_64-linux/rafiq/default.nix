{
  pkgs,
  inputs,
  osConfig,
  lib,
  system,
  ...
}:
let
  inherit (lib) mkMerge mkIf;
  mkEmailAccount = address: {
    inherit address;
    maildir.path = address;
    userName = address;
    realName = "Mohammad Rafiq";
    passwordCommand = "sudo cat ${osConfig.sops.secrets."rafiq/personalEmailPassword".path}";
    imap = {
      host = "imap.forwardemail.net";
      port = 993;
    };
    smtp = {
      host = "smtp.forwardemail.net";
      port = 465;
    };
    thunderbird.enable = true;
  };
in
{
  config = mkMerge [
    (mkIf osConfig.desktop.enable (import ./desktop { inherit lib inputs system; }))
    (mkIf osConfig.desktop.enable {
      home.persistence."/persist/home/rafiq".directories = [
        "docs"
        "repos"
        "vids"
        "tmp"
        ".tor project"
        ".local/share/PrismLauncher"
      ];
      programs = {
        obs-studio.enable = true;
        thunderbird.enable = true;
        thunderbird.profiles.rafiq.isDefault = true;
      };
      home.packages = with pkgs; [
        stremio
        tor-browser
        prismlauncher
      ];
    })
    {
      accounts = {
        email = {
          maildirBasePath = "mail";
          accounts = {
            "rafiq@rrv.sh" = {
              primary = true;
            } // mkEmailAccount "rafiq@rrv.sh";
            "mohammadrafiq@rrv.sh" = mkEmailAccount "mohammadrafiq@rrv.sh";
          };
        };
      };
      cli = {
        shell = "zsh";
        finder = "fzf";
        screensaver.enable = true;
        screensaver.timeout = "100";
        screensaver.command = "cbonsai -S -w 0.1 -L 40 -M 2 -b 2";
        editor = "nvf";
        file-browser = "yazi";
        multiplexer = "zellij";
        fetch = "hyfetch";
        git.name = "Mohammad Rafiq";
        git.email = "rafiq@rrv.sh";
        git.defaultBranch = "prime";
      };
      home = {
        shellAliases = {
          v = "nvim";
          e = "edit";
        };

        packages = with pkgs; [
          cbonsai
          ripgrep
          devenv
          pantheon.rebuild
          pantheon.deploy
          pantheon.edit
          pantheon.commit
          pantheon.check
          inputs.nixspect.packages."x86_64-linux".nixspect
        ];

        persistence."/persist/home/rafiq".directories = [
        ];
      };
      programs = {
        nh.enable = true;
        tealdeer.enable = true;
        tealdeer.settings.updates.auto_update = true;
        pay-respects.enable = true;
        direnv = {
          enable = true;
          nix-direnv.enable = true;
        };
      };
    }
  ];
}
