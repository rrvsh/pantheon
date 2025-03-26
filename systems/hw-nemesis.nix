{
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/e5005ea6-6c5a-4ab3-9767-ce7772582024";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/6BBE-0E70";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };
}
