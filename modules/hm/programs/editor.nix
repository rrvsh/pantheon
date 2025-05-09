{
  config,
  lib,
  inputs,
  ...
}:
let
  username = config.nixosModules.mainUser;
in
{
  config = lib.mkIf (config.hmModules.mainApps.editor == "nvf") (
    lib.mkMerge [
      {
        nix.settings.substituters = [ "https://nvf.cachix.org" ];
        nix.settings.trusted-public-keys = [
          "nvf.cachix.org-1:GMQWiUhZ6ux9D5CvFFMwnc2nFrUHTeGaXRlVBXo+naI="
        ];

        home-manager.users.${username} = {
          imports = [
            inputs.nvf.homeManagerModules.default
            ./nvf/core.nix
          ];
        };
      }
    ]
  );
}
