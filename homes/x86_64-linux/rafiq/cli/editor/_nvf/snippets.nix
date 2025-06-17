{ pkgs }:
{
  luasnip = {
    enable = true;
    setupOpts.enable_autosnippets = true;
    loaders = ''
      require('luasnip.loaders.from_vscode').lazy_load()
      require('luasnip.loaders.from_snipmate').lazy_load()
    '';
    providers = with pkgs.vimPlugins; [ vim-snippets ];
  };
}
