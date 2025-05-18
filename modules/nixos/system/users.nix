{ config, lib, pkgs, ... }:
{
  config = lib.mkMerge [
    {
      users.users."${config.system.mainUser}" = {
        isNormalUser = true;
        initialPassword = "1";
        extraGroups = [ 
	  "wheel" 
	];
        packages = with pkgs; [
          git
          neovim
        ];
      };
    }
  ];
}
