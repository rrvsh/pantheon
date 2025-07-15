{
  flake.modules.nixos.default =
    { hostConfig, ... }:
    let
      inherit (hostConfig.machine) platform;
      arch = if platform == "amd" || platform == "intel" then "x86_64" else "aarch64";
    in
    {
      hardware.cpu.${platform}.updateMicrocode = true;
      boot.kernelModules = [ "kvm-${platform}" ];
      nixpkgs.hostPlatform = "${arch}-linux";
    };

  flake.modules.darwin.default =
    { hostConfig, ... }:
    let
      inherit (hostConfig.machine) platform;
      arch = if platform == "intel" then "x86_64" else "aarch64";
    in
    {
      nixpkgs.hostPlatform = "${arch}-darwin";
    };
}
