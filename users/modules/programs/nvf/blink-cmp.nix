{
  programs.nvf.settings.vim.autocomplete.blink-cmp = {
    enable = true;
    friendly-snippets.enable = true; # code snippets
    setupOpts = {
      completion = {
        documentation.auto_show_delay_ms = 0;
      };
    };
    sourcePlugins = {
      emoji.enable = true;
      ripgrep.enable = true;
      spell.enable = true;
    };
  };
}
