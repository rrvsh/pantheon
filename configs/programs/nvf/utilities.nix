{
  programs.nvf.settings.vim = {
    utility = {
      direnv.enable = true;
      nix-develop.enable = true;
      leetcode-nvim = {
        enable = true;
        setupOpts = {
          image_support = true; # requires image.nvim
          lang = "rust";
        };
      };
      mkdir.enable = true;
      new-file-template = {
        enable = true;
        # add a directory containing lua/tempaltes/*.lua to vim.additionalRuntimePaths
        # TODO: add for nix
      };
    };
    session.nvim-session-manager.enable = true;
  };
}
