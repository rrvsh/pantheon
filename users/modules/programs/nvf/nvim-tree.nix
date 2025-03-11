{
  programs.nvf.settings.vim = {
    keymaps = [
      {
        key = "t";
        mode = "n";
        action = ":NvimTreeToggle<CR>";
        silent = true;
      }
    ];
    filetree.nvimTree = {
      enable = true;
      setupOpts = {
        disable_netrw = true;
        hijack_netrw = true;
        hijack_cursor = true;
        actions.open_file.quit_on_open = true;
        hijack_directories.auto_open = false;
        view = {
          cursorline = true;
          side = "right";
          width = {
            min = "25%";
            max = "25%";
          };
        };
      };
    };
  };
}
