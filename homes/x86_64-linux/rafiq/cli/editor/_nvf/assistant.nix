{
  avante-nvim = {
    enable = true;
    setupOpts = {
      provider = "gemini";
      auto_suggestions_provider = "gemini";
      auto_suggestions = true;
      windows.ask.floating = true;
      input = {
        provider = "snacks";
        provider_opts.title = "Avante Input";
        provider_opts.icon = " ";
      };
      mappings.suggestion = {
        accept = "<M-C-L>";
        next = "<M-C-K>";
        prev = "<M-C-J>";
        dismiss = "<M-C-H>";
      };
    };
  };
}
