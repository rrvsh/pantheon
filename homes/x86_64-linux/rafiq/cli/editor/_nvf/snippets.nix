{ pkgs }:
{
  luasnip = {
    enable = true;
    setupOpts.enable_autosnippets = true;
    providers = with pkgs.vimPlugins; [ vim-snippets ];
    customSnippets.snipmate = {
      nix = [
        {
          trigger = "mod";
          description = "empty module";
          body = # nix
            ''
              {config, lib}:
              let
                cfg = config.$1;
              in
              {
                options.$1 = { $2 };
                config = $3;
              }
            '';
        }
      ];
    };
  };
}
