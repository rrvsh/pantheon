{ pkgs }:
{
  luasnip = {
    enable = true;
    setupOpts.enable_autosnippets = true;
    providers = with pkgs.vimPlugins; [ vim-snippets ];
    customSnippets.snipmate = {
      all = [
        {
          trigger = "if";
          body = "if $1 else $2";
        }
      ];
      nix = [
        {
          trigger = "mkOption";
          body = ''
            mkOption {
              type = $1;
              default = $2;
              description = $3;
              example = $4;
            }
          '';
        }
      ];
    };
  };
}
