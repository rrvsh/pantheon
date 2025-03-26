{
  inputs,
  pkgs,
  ...
}:
let
  yazi-plugins = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "273019910c1111a388dd20e057606016f4bd0d17";
    hash = "sha256-80mR86UWgD11XuzpVNn56fmGRkvj0af2cFaZkU8M31I=";
  };
in
{
  home-manager.users.rafiq = {
    programs.yazi = {
      enable = true;
      package = inputs.yazi.packages.${pkgs.system}.default;
      shellWrapperName = "y";
      # yazi.toml
      settings = {
        manager = {
          sort_by = "natural"; # Sort naturally, e.g. 1.md < 2.md < 10.md
          sort_translit = true; # Transliterate filenames for sorting
          show_hidden = true;
        };
        plugin = {
          prepend_preloaders = [
            {
              mime = "{audio,video,image}/*";
              run = "mediainfo";
            }
            {
              mime = "application/subrip";
              run = "mediainfo";
            }
          ];
          prepend_previewers = [
            {
              name = "*.md";
              run = "glow";
            }
            {
              mime = "{audio,video,image}/*";
              run = "mediainfo";
            }
            {
              mime = "application/subrip";
              run = "mediainfo";
            }
          ];
          prepend_fetchers = [
            {
              id = "git";
              name = "*";
              run = "git";
            }
            {
              id = "git";
              name = "*/";
              run = "git";
            }
          ];
        };
      };
      # ~/.config/yazi/keymap.toml
      keymap = {
        manager.prepend_keymap = [
          {
            on = "l";
            run = "plugin smart-enter";
            desc = "Enter the child directory or open the file.";
          }
          {
            on = "M";
            run = "plugin mount";
            desc = "Open the mount.yazi menu.";
          }
        ];
      };
      plugins = {
        full-border = "${yazi-plugins}/full-border.yazi";
        smart-enter = "${yazi-plugins}/smart-enter.yazi";
        git = "${yazi-plugins}/git.yazi";
        mount = "${yazi-plugins}/mount.yazi";
        glow = pkgs.fetchFromGitHub {
          owner = "Reledia";
          repo = "glow.yazi";
          rev = "c76bf4fb612079480d305fe6fe570bddfe4f99d3";
          sha256 = "sha256-DPud1Mfagl2z490f5L69ZPnZmVCa0ROXtFeDbEegBBU=";
        };
        mediainfo = pkgs.fetchFromGitHub {
          owner = "boydaihungst";
          repo = "mediainfo.yazi";
          rev = "447fe95239a488459cfdbd12f3293d91ac6ae0d7";
          sha256 = "sha256-U6rr3TrFTtnibrwJdJ4rN2Xco4Bt4QbwEVUTNXlWRps=";
        };
        starship = pkgs.fetchFromGitHub {
          owner = "Rolv-Apneseth";
          repo = "starship.yazi";
          rev = "6c639b474aabb17f5fecce18a4c97bf90b016512";
          sha256 = "sha256-bhLUziCDnF4QDCyysRn7Az35RAy8ibZIVUzoPgyEO1A=";
        };
      };
      initLua = ''
        require("full-border"):setup()
        require("git"):setup()
        require("starship"):setup({
          config_file = "${./yazi/starship.toml}",
        })
      '';
    };
    home.packages = with pkgs; [
      jq # JSON preview
      poppler_utils # PDF preview
      _7zz # archive extraction and preview
      ffmpeg
      ffmpegthumbnailer # video thumbnails
      fd # file searching
      ripgrep # file content searching
      fzf # quick file subtree navigation
      zoxide # historical directories navigation
      imagemagick # SVG, font, HEIC, JPEG preview
      chafa # image/gif preview
      glow # markdown preview
      mediainfo # media metadata
    ];
  };
}
