{
  programs.nvf.settings.vim = {
    projects.project-nvim.enable = true;
    utility = {
      # ccc is a colour picker
      ccc.enable = true;
      # diffview-nvim lets you easily go through diffs for a given rev
      diffview-nvim.enable = true;
      # direnv.vim syncs the nvim shell environment with direnv
      direnv.enable = true;
      # icon-picker gives you a way to pick icons from nerd fonts
      # TODO: find out keybinds
      icon-picker.enable = true;
      # image rendering
      # TODO: look into image-magick and if it is needed
      images.image-nvim.enable = true;
      # leetcode
      leetcode-nvim = {
        enable = true;
        setupOpts = {
          image_support = true; # requires image.nvim
          lang = "rust";
        };
      };
      # mkdir.nvim creates directory when the path doesnt exist
      mkdir.enable = true;
      motion = {
        hop.enable = true; # <leader>h
        leap.enable = true;
        leap.mappings = {
          # default mappings
          # - Leap backward till:<leader>sX
          # - Leap backward to:<leader>sS
          # - Leap forward till:<leader>sx
          # - Leap forward to:<leader>ss
          # - Leap from window:gs
        };
        # precognition.nvim shows hints for motions
        precognition = {
          enable = true;
          setupOpts = {
            # TODO: may want to fix dashboard
          };
        };
      };
      # multicursors.nvim enables vscode like multicursors
      multicursors.enable = true;
      # new-file-template.nvim automatically inserts templates in new files
      new-file-template = {
        enable = true;
        # add a directory containing lua/tempaltes/*.lua to vim.additionalRuntimePaths
        # TODO: add for nix
      };
      # allows usage of nix commands in nvim
      nix-develop.enable = true;
      # aerial.nvim shows a preview of your entire code file
      outline.aerial-nvim.enable = true; # "g0"
      # glow.nvim displays a floating window with a markdown preview
      preview.glow.enable = true; # "<leader>p"
      # nvim-surround allows you to easily surround and delete words or phrases
      surround.enable = true;
      # vim-wakatime allows sending statistics to wakatime or a compatible backend vim-wakatime.enable = true;
      # yanky allows cycling through yank history when putting text
      yanky-nvim.enable = true;
      # yazi-nvim gives integration with yazi
      # default mappings:
      # - Open yazi at the current file [yazi.nvim]:<leader>-
      # - Open the file manager in nvim’s working directory [yazi.nvim]:<leader>cw
      # - Resume the last yazi session [yazi.nvim]:<c-up>
      yazi-nvim.enable = true;
      yazi-nvim.setupOpts.open_for_directories = true; # FIXME: does this work with neotree?
    };
    # TODO: look into terminal integration
    terminal.toggleterm.enable = true;
    terminal.toggleterm.lazygit.enable = true;
    # nvim session manager manages sessions like folders in vscode
    session.nvim-session-manager = {
      enable = true;
      mappings = {
        # default mappings:
        # - Delete session:<leader>sd
        # - Load last session:<leader>slt
        # - Load session:<leader>sl
        # - Save current session:<leader>sc
      };
    };
    comments.comment-nvim.enable = true;
  };
}
