{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:
{
  config = lib.mkMerge [
    (lib.mkIf (osConfig.hardware.gpu == "nvidia") {
      home.packages = [ pkgs.stable-diffusion-webui.forge.cuda ];
      home.persistence."/persist/home/${config.snowfallorg.user.name}".directories = [
        ".local/share/stable-diffusion-webui"
      ];
    })
  ];
}
