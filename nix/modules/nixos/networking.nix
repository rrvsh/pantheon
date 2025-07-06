{
  flake.modules.nixos.networking =
    { hostName, ... }:
    {
      networking = { inherit hostName; };
    };
}
