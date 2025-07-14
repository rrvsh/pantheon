{ config, ... }:
let
  cfg = config.flake;
in
{
  flake.modules.nixos.default = {
    security.sudo.wheelNeedsPassword = false;
    nix.settings.trusted-users = [ "@wheel" ];
    users.users.${cfg.admin.username}.extraGroups = [ "wheel" ];
  };
  flake.modules.darwin.default.security = {
    sudo.extraConfig = "%admin          ALL = (ALL) NOPASSWD: ALL";
    pam.services.sudo_local = {
      enable = true;
      reattach = true;
      touchIdAuth = true;
    };
  };
}
