{ pkgs }:
{
  luasnip = {
    enable = true;
    setupOpts.enable_autosnippets = true;
    providers = with pkgs.vimPlugins; [ vim-snippets ];
    loaders = "require('luasnip.loaders.from_vscode').lazy_load()";
    customSnippets.snipmate = {
      nix = [
        {
          trigger = "mod";
          description = "empty module";
          body = # nix
            ''
              {config, lib, ...}:
              let
                cfg = config.$1;
              in
              {
                options.$1 = { $2 };
                config = $3;
              }
            '';
        }
        {
          trigger = "flake";
          body = # nix
            ''
              { config, ... }:
              let
                cfg = config.flake;
              in
              {
                flake.modules.nixos.default =
                  { config, ...}:
                  {
                    imports = [
                      $1
                    ];
                    options = {
                      $2
                    };
                    config = {
                      $3
                    };
                  };
              }
            '';
        }
      ];
    };
  };
}
