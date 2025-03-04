{pkgs, ...}: {
  users.users.rafiq = {
    isNormalUser = true;
    description = "rafiq";
    extraGroups = ["networkmanager" "wheel"];
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.systemPackages = with pkgs; [
    git
  ];
}
