{ lib, config, ... }:
{
  options.server.mountHelios = lib.mkEnableOption "";

  config = lib.mkIf config.server.mountHelios {
    sops.secrets."rafiq/oldSMBCredentials" = { };
    sops.templates."smb-credentials".content = ''
      username=rafiq
      password=${config.sops.placeholder."rafiq/oldSMBCredentials"}
    '';
    fileSystems = {
      "/media/helios/data" = {
        device = "//helios/data";
        fsType = "cifs";
        options = [
          "x-systemd.automount"
          "x-systemd.requires=tailscaled.service"
          "x-systemd.mount-timeout=0"
        ];
      };
      "/media/helios/rafiqcloud" = {
        device = "//helios/rafiqcloud";
        fsType = "cifs";
        options = [
          "x-systemd.automount"
          "x-systemd.requires=tailscaled.service"
          "x-systemd.mount-timeout=0"
          "credentials=${config.sops.templates."smb-credentials".path}"
        ];
      };
      "/media/helios/rafiqmedia" = {
        device = "//helios/rafiqmedia";
        fsType = "cifs";
        options = [
          "x-systemd.automount"
          "x-systemd.requires=tailscaled.service"
          "x-systemd.mount-timeout=0"
          "credentials=${config.sops.templates."smb-credentials".path}"
        ];
      };
    };
  };
}
