{ config, lib, ... }:
{
  config = lib.mkIf (config.cli.editor == "nvf") {
    programs.nvf = {
      enable = true;
      settings.vim = {
        utility.yazi-nvim = {
          enable = true;
	  mappings = {
            openYazi = "t";
            openYaziDir = "T";
	  };
	  setupOpts.open_for_directories = true;
	};
      };
    };
  };
}
