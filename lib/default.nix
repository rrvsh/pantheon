{
  inputs,
  self,
  workingDir,
  ...
}:
{
  mkSystem = type: hostname: bootDisk: {
    name = "${hostname}";
    value = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit
          self
          inputs
          type
          hostname
          bootDisk
          ;
      };
      modules = [
        "${workingDir}/modules/nixos"
        "${workingDir}/modules/hm"
        "${workingDir}/hosts/common.nix"
        "${workingDir}/hosts/${hostname}.nix"
      ];
    };
  };
}
