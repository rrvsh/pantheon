{ config, lib, pkgs, ... }:
{
  hardware.drives.btrfs = {
    enable = true;
    drive = "/dev/disk/by-id/nvme-CT2000P3SSD8_2325E6E77434";
    ephemeralRoot = true;
  };
  hardware.gpu = "nvidia";

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  networking.hostName = "nemesis"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  time.timeZone = "Asia/Singapore";
  i18n.defaultLocale = "en_US.UTF-8";
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  users.users.rafiq = {
    isNormalUser = true;
    initialPassword = "1";
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      git
      neovim
    ];
  };
  nix.settings.experimental-features = ["nix-command" "flakes"];
  system.stateVersion = "25.05"; # Did you read the comment?
}

