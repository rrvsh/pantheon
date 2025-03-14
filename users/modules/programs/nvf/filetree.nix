{
  programs.nvf.settings.vim.filetree = {
    # press ? in the tree view for a list of keybindings
    # < and > to switch sources
    # backspace to go up one level
    neo-tree = {
      enable = true;
      setupOpts = {
        enable_cursor_hijack = true; # keep the cursor on the first char
        hijack_netrw_behavior = "disabled";
      };
    };
    # TODO: add keymap for :NeoTree action=show position=right toggle=true reveal=true
    # action=show is to not focus the window
    # toggle will toggle the window
    # reveal will find and focus the current file
  };
}
