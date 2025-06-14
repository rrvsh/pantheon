{
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
  imports =
    (optional osConfig.desktop.enable (import-tree ./desktop))
    ++ singleton (import-tree ./cli);

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
  };
}
