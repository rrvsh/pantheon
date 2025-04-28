{
  config,
  lib,
  ...
}:
let
  moduleName = "nw-config";
  cfg = config."${moduleName}";
in
{
  options = {
    "${moduleName}" = {
      wol = {
        enable = lib.mkEnableOption "Enable wake on lan.";
        interface = lib.mkOption {
          type = lib.types.str;
          default = "";
          example = "enp12s0";
          description = "What interface to enable wake on lan for.";
        };
      };
      backend = lib.mkOption {
        type = lib.types.str;
        default = "";
        example = "networkmanager";
        description = "What software to use to manage your networks.";
      };
    };
  };

  config = lib.mkMerge [
    {
      networking = {
        hostName = config.nixosModules.hostname;
        useDHCP = lib.mkDefault true;
        firewall.enable = true;
      };
    }
    {
      services.openssh.enable = true;
      networking.firewall.allowedTCPPorts = [ 22 ];
    }
    {
      services.tailscale = {
        enable = true;
        authKeyFile = config.sops.secrets.ts_auth_key.path;
      };
    }
    (lib.mkIf (cfg.backend == "networkmanager") {
      networking = {
        networkmanager.enable = true;
        networkmanager.wifi.backend = "iwd";
      };
    })
    (lib.mkIf cfg.wol.enable {
      networking.interfaces."${cfg.wol.interface}".wakeOnLan = {
        enable = true;
        policy = [
          "phy"
          "unicast"
          "multicast"
          "broadcast"
          "arp"
          "magic"
          "secureon"
        ];
      };
    })
  ];
}
