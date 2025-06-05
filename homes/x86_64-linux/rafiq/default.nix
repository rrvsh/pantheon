{
  pkgs,
  inputs,
  osConfig,
  ...
}:
{
  accounts = {
    email = {
      maildirBasePath = "mail";
      accounts = {
        "rafiq@rrv.sh" = {
          primary = true;
          address = "rafiq@rrv.sh";
          maildir.path = "rafiq@rrv.sh";
          userName = "rafiq@rrv.sh";
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
        };
        "mohammadrafiq@rrv.sh" = {
          address = "mohammadrafiq@rrv.sh";
          maildir.path = "mohammadrafiq@rrv.sh";
          userName = "mohammadrafiq@rrv.sh";
          realName = "Mohammad Rafiq";
          passwordCommand = "sudo cat ${osConfig.sops.secrets."rafiq/workEmailPassword".path}";
          imap = {
            host = "imap.forwardemail.net";
            port = 993;
          };
          smtp = {
            host = "smtp.forwardemail.net";
            port = 465;
          };
        };
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
      stremio
      pantheon.rebuild
      pantheon.edit
      inputs.nixspect.packages."x86_64-linux".nixspect
    ];

    persistence."/persist/home/rafiq".directories = [ "repos" ];
  };
  programs = {
    nh.enable = true;
    tealdeer.enable = true;
    pay-respects = {
      enable = true;
    };
    tealdeer.settings.updates.auto_update = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
