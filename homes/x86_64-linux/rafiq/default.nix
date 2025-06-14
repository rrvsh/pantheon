{
  pkgs,
  inputs,
  osConfig,
  lib,
  ...
}:
let
  inherit (lib) singleton optional;
  inherit (inputs) import-tree;
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
    thunderbird.enable = osConfig.desktop.enable;
  };
in
{
  imports = (optional osConfig.desktop.enable (import-tree ./desktop)) ++ singleton (import-tree ./cli);

  config = {
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
  };
}
