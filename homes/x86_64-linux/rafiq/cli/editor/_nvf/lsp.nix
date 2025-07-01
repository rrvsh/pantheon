{
  enable = true;
  # Show virtual text hints
  inlayHints.enable = true;
  lightbulb.enable = true;
  # Show icons for lsp actions
  lspkind.enable = true;
  null-ls.enable = true;
  otter-nvim = {
    enable = true;
    setupOpts = {
      buffers.set_filetype = true;
      buffers.write_to_disk = true;
      handle_leading_whitespace = true;
    };
  };
}
