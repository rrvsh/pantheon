{ config, lib, ... }:
{
  config = lib.mkIf (config.cli.editor == "nvf") {
    home.sessionVariables.EDITOR = "nvim";
    programs.nvf = {
      enable = true;
      settings.vim = {
      keymaps = [
        {
          desc = "Open the file path under the cursor, making the file if it doesn't exist.";
          key = "gf";
          mode = "n";
          action = ":cd %:p:h<CR>:e <cfile><CR>";
          silent = true;
        }
      ];
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
