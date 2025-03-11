{
  programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        key = "t";
        action = ":NvimTreeToggle<CR>";
        options = {
          silent = true;
        };
      }
    ];
    plugins = {
      web-devicons.enable = true;

      nvim-tree = {
        enable = true;
        autoClose = true;
        disableNetrw = true;
        hijackNetrw = true;
        hijackCursor = true;
        view = {
          cursorline = true;
          side = "right";
          width = "25%";
        };
      };
    };
  };
}
