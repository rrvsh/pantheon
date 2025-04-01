{
  programs.nvf.settings.vim.languages = {
    # The below settings enable defaults for all languages
    enableDAP = true;
    enableExtraDiagnostics = true;
    enableFormat = true;
    enableLSP = true;
    enableTreesitter = true;

    # Enable specific languages
    clang.enable = true;
    css.enable = true;
    lua.enable = true;
    markdown.enable = true;
    markdown.extensions.render-markdown-nvim.enable = true;
    nix.enable = true;
    nix.format.type = "nixfmt";
    python.enable = true;
    rust.enable = true;
    rust.crates.enable = true;
    ts.enable = true;

    # Did not really check these
    bash.enable = true;
    csharp.enable = true;
    go.enable = true;
    haskell.enable = true;
    html.enable = true;
    java.enable = true;
    sql.enable = true;
    yaml.enable = true;
  };
}
