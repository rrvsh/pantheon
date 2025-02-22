{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  ##############################
  ###        Graphics        ###
  ##############################
  
  # Add the nvidia driver modules to the initramfs.
  # This is not needed for later drivers.
  boot.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
  boot.kernelParams = [ "nvidia_drm.modeset=1" ]; # Direct Rendering Manager
  services.xserver.videoDrivers = ["nvidia"];
  hardware = {
    graphics.enable = true;
    nvidia = {
      modesetting.enable = true;
      powerManagement = {
        enable = false;
	      finegrained = false;
      };
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };    
  };

  environment.variables.NIXOS_OZONE_WL = "1"; # Hint to electron apps to use Wayland
  environment.variables.LIBVA_DRIVER_NAME = "nvidia";
  environment.variables.__GLX_VENDOR_LIBRARY_NAME = "nvidia";
  environment.variables.NVD_BACKEND = "direct"; # Set VAAPI driver backend
  
  ##############################
  ###       Networking       ###
  ##############################

  networking.hostName = "nemesis"; # Define your hostname.

  networking.networkmanager.enable = true;

  ##############################
  ###         System         ###
  ##############################

  # Set your time zone.
  time.timeZone = "Asia/Singapore";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_SG.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_SG.UTF-8";
    LC_IDENTIFICATION = "en_SG.UTF-8";
    LC_MEASUREMENT = "en_SG.UTF-8";
    LC_MONETARY = "en_SG.UTF-8";
    LC_NAME = "en_SG.UTF-8";
    LC_NUMERIC = "en_SG.UTF-8";
    LC_PAPER = "en_SG.UTF-8";
    LC_TELEPHONE = "en_SG.UTF-8";
    LC_TIME = "en_SG.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rafiq = {
    isNormalUser = true;
    description = "Mohammad Rafiq";
    extraGroups = [ "networkmanager" "wheel" "podman" ];
  };

  ##############################
  ###        Packages        ###
  ##############################

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.variables.EDITOR = "vim";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    gnumake # TODO check if needed
    gcc # TODO check if needed
    pciutils # TODO check if needed
    file # TODO check if needed

    # Graphics
    cudatoolkit
    nvidia-vaapi-driver # Required for hardware acceleration on Wayland

    # Terminal
    kitty # Terminal Emulator (requirement for default Hyprland)

    # Browser
    firefox
  ];

  ##############################
  ###        Services        ###
  ##############################

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
  };

  programs.hyprland = {
    enable = true;

    # Use the hyprland package defined in flake.nix instead of the nixpkgs-unstable
    # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  virtualisation = {
    # Enable common container config files in /etc/containers
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true; # for compose containers to see each other
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
