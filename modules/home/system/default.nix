{ config, ... }:
{
  home.persistence."/persist/home/${config.snowfallorg.user.name}" = {
	directories = [
	".ssh"
	".config/sops/age"
	];
	allowOther = true;
  };

  home.stateVersion = "24.11";
}
