{
  programs.nvf.settings.vim.languages = {
    # The below settings enable defaults for all languages
    enableDAP = true;
    enableExtraDiagnostics = true;
    enableFormat = true;
    enableLSP = true;
    enableTreesitter = true;

    # Enable specific languages
    nix.enable = true;
    nix.format.type = "nixfmt";
    rust.enable = true;
    clang.enable = true;
    lua.enable = true;
    python.enable = true;
  };
}
