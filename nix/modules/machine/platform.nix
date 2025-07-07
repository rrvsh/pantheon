{ config, ... }:
{
  flake.modules.nixos.default =
    { hostName, ... }:
    let
      inherit (config.flake.manifest.hosts.nixos.${hostName}.machine) platform;
      arch = if platform == "amd" || platform == "intel" then "x86_64" else "aarch64";
    in
    {
      hardware.cpu.${platform}.updateMicrocode = true;
      boot.kernelModules = [ "kvm-${platform}" ];
      nixpkgs.hostPlatform = "${arch}-linux";
    };
}
