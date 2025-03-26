{ inputs, ... }:
{
  imports = [
    ../themes/cursors/banana-cursor.nix
    ../themes/darkviolet.nix
    ../themes/fonts/sauce-code-pro.nix
    ./modules/programs/getty.nix
    ./modules/programs/hyprland.nix
    ./modules/programs/hyprlock.nix
    inputs.stylix.nixosModules.stylix
    ./modules/hardware/bluetooth.nix
  ];

  # Enable basic fonts for reasonable Unicode coverage
  fonts.enableDefaultPackages = true;

  stylix = {
    enable = true;
    image = ../../media/wallpaper.jpg;
    homeManagerIntegration.autoImport = false;
    homeManagerIntegration.followSystem = false;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    extraConfig = { };
    jack.enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };
}
