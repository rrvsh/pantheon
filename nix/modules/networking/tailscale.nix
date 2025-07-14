{ config, ... }:
let
  inherit (config.flake.paths) secrets;
in
{
  flake.modules.nixos.default =
    { config, ... }:
    {
      services.tailscale = {
        enable = true;
        authKeyFile = config.sops.secrets."tailscale/client-secret".path;
        authKeyParameters.preauthorized = true;
      };
      persistDirs = [ "/var/lib/tailscale" ];
      sops.secrets."tailscale/client-secret".sopsFile = secrets + "/tailscale.yaml";
    };
  flake.modules.darwin.default =
    { pkgs, ... }:
    {
      services.tailscale = {
        enable = true;
        package = pkgs.tailscale.overrideAttrs {
          checkFlags = [
            "-skip"
            "TestProtocolQEMU|TestProtocolUnixDgram"
          ];
        };
      };
    };
}
