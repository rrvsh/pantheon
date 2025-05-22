{
  enableExtraDiagnostics = true;
  enableFormat = true;
  enableTreesitter = true;
  bash.enable = true;
  clang.enable = true;
  csharp.enable = true;
  css.enable = true;
  go.enable = true;
  html.enable = true;
  lua.enable = true;
  markdown.enable = true;
  markdown.extensions.markview-nvim.enable = true;
  nix = {
    enable = true;
    format.type = "nixfmt";
    lsp.server = "nil";
  };
  python.enable = true;
  python.lsp.server = "python-lsp-server";
  rust.enable = true;
  rust.crates.enable = true;
  ts.enable = true;
  ts.extensions.ts-error-translator.enable = true;
  typst.enable = true;
  typst.extensions.typst-preview-nvim.enable = true;
  yaml.enable = true;
}
