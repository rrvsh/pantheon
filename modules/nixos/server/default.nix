{
  lib,
  config,
  ...
}:
{
  options.server = {
    mountHelios = lib.mkEnableOption "";
  };

  config = lib.mkMerge [
    (lib.mkIf config.server.mountHelios {
      fileSystems."/media/helios/data" = {
        device = "//helios/data";
        fsType = "cifs";
        options = [
          "x-systemd.automount"
          "x-systemd.requires=tailscaled.service"
          "x-systemd.mount-timeout=0"
        ];
      };
      fileSystems."/media/helios/rafiqcloud" = {
        device = "//helios/rafiqcloud";
        fsType = "cifs";
        options = [
          "x-systemd.automount"
          "x-systemd.requires=tailscaled.service"
          "x-systemd.mount-timeout=0"
          "credentials=${config.sops.templates."smb-credentials".path}"
        ];
      };
      fileSystems."/media/helios/rafiqmedia" = {
        device = "//helios/rafiqmedia";
        fsType = "cifs";
        options = [
          "x-systemd.automount"
          "x-systemd.requires=tailscaled.service"
          "x-systemd.mount-timeout=0"
          "credentials=${config.sops.templates."smb-credentials".path}"
        ];
      };
    })
  ];
}
