{ inputs, ... }: {
  programs.nvf.settings.vim.languages.nix = {
    enable = true;
    lsp = {
      # package = inputs.nixd.packages.default;
      server = "nixd";
    };
  };
}
