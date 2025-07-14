{
  enableExtraDiagnostics = true;
  enableFormat = true;
  enableTreesitter = true;
  bash.enable = true;
  clang.enable = true;
  # broken on macos
  # csharp.enable = true;
  css.enable = true;
  go.enable = true;
  html.enable = true;
  lua.enable = true;
  markdown = {
    enable = true;
    extensions.markview-nvim.enable = true;
    format.type = "prettierd";
  };
  nix = {
    enable = true;
    format.type = "nixfmt";
    lsp.server = "nil";
  };
  python = {
    enable = true;
    format.type = "ruff";
    lsp.server = "pyright";
  };
  rust.enable = true;
  rust.crates.enable = true;
  ts.enable = true;
  ts.extensions.ts-error-translator.enable = true;
  typst.enable = true;
  typst.extensions.typst-preview-nvim.enable = true;
  yaml.enable = true;
}
