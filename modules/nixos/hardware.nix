{
  config,
  lib,
  pkgs,
  ...
}:
let
  moduleName = "hardware-config";
  cfg = config."${moduleName}";
in
{
  options = {
    "${moduleName}" = {
      cpu = lib.mkOption {
        type = lib.types.str;
        default = "";
        example = "amd";
        description = "What CPU is being used.";
      };
      gpu = lib.mkOption {
        type = lib.types.str;
        default = "";
        example = "nvidia";
        description = "What GPU is being used.";
      };
      usbAutoMount = lib.mkEnableOption "Enable auto mounting USB drives.";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf (cfg.cpu != "") {
      nixpkgs.hostPlatform = lib.mkIf (cfg.cpu == "amd" || cfg.cpu == "intel") "x86_64-linux";
      # CPU Settings
      boot.kernelModules =
        lib.optionals (cfg.cpu == "intel") [ "kvm-intel" ]
        ++ lib.optionals (cfg.cpu == "amd") [ "kvm-amd" ];
      hardware.cpu =
        lib.mkIf (cfg.cpu == "intel") { intel.updateMicrocode = true; }
        // lib.mkIf (cfg.cpu == "amd") { amd.updateMicrocode = true; };
    })
    (lib.mkIf (cfg.gpu == "nvidia") {
      # Accept the license by default; needed for some packages.
      nixpkgs.config.nvidia.acceptLicense = true;
      nix.settings = {
        substituters = [ "https://cuda-maintainers.cachix.org" ];
        trusted-public-keys = [
          "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
        ];
      };
      services.xserver.videoDrivers = [ "nvidia" ];
      environment.variables = {
        GBM_BACKEND = "nvidia-drm";
        LIBVA_DRIVER_NAME = "nvidia";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      };
      hardware = {
        enableRedistributableFirmware = true;
        nvidia-container-toolkit.enable = true;
        graphics = {
          enable = true;
          driSupport = true;
          driSupport32Bit = true;
          extraPackages = with pkgs; [
            nvidia-vaapi-driver # hardware acceleration
          ];
        };
        nvidia = {
          modesetting.enable = true;
          open = false;
          nvidiaSettings = true;
          nvidiaPersistenced = true;
          package = config.boot.kernelPackages.nvidiaPackages.latest;
        };
      };
      boot.initrd.availableKernelModules = [
        "nvidia"
        "nvidia_modeset"
        "nvidia_uvm"
        "nvidia_drm"
      ];
    })
    (lib.mkIf cfg.usbAutoMount {
      services.udisks2 = {
        enable = true;
        mountOnMedia = true;
      };
    })
  ];
}
