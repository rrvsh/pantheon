{ osConfig, lib, ... }:
let
  mkEmailAccount = address: {
    inherit address;
    maildir.path = address;
    userName = address;
    realName = "Mohammad Rafiq";
    passwordCommand = "sudo cat ${osConfig.sops.secrets."rafiq/personalEmailPassword".path}";
    mbsync = {
      enable = true;
      create = "both";
    };
    imap = {
      host = "imap.forwardemail.net";
      port = 993;
    };
    smtp = {
      host = "smtp.forwardemail.net";
      port = 465;
    };
    thunderbird.enable = osConfig.desktop.enable;
    neomutt.enable = true;
    neomutt.mailboxType = "imap";
    himalaya.enable = true;
  };
in
{
  programs.himalaya.enable = true;
  programs.neomutt = {
    enable = true;
    vimKeys = true;
  };
  persistDirs = [
    "mail/rafiq@rrv.sh"
    "mail/mohammadrafiq@rrv.sh"
  ];
  accounts.email = {
    maildirBasePath = "mail";
    accounts = {
      "rafiq@rrv.sh" = mkEmailAccount "rafiq@rrv.sh" // {
        primary = true;
      };
      "mohammadrafiq@rrv.sh" = mkEmailAccount "mohammadrafiq@rrv.sh";
    };
  };
}
