{ pkgs }:
{
  luasnip = {
    enable = true;
    setupOpts.enable_autosnippets = true;
    providers = with pkgs.vimPlugins; [ vim-snippets ];
  };
}
