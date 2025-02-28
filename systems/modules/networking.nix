#
# Common networking settings for all machines.
# Anything system-specific should not be here.
#
{
  networking = {
    # Enable networkManager
    # TODO: Look into the networkManager options.
    networkmanager.enable = true;

    # Configures a simple stateful firewall.
    # By default, it doesn't allow any incoming connections.
    firewall = {
      enable = true; 
      allowedTCPPorts = [ 
        22 # SSH
      ];
      allowedUDPPorts = [];
    };
  };

  # Add binary caches to avoid having to compile them
  nix.settings = {
    substituters = [
      "https://hyprland.cachix.org" 
      "https://cuda-maintainers.cachix.org" 
      "https://nix-community.cachix.org" 
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" 
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  # TODO: look into openssh and tailscale settings.
  services.openssh.enable = true;
  services.tailscale.enable = true;
}
