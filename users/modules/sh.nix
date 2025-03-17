# Default shell utilities and programs
{
  imports = [
    ./programs/btop.nix
    ./programs/direnv.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/nvf.nix
    ./programs/starship.nix
    ./programs/tealdeer.nix
    ./programs/yazi.nix
    ./programs/zellij.nix
    ./programs/zsh.nix
    ./programs/thefuck.nix
    ./scripts
  ];
  home.shell.enableShellIntegration = true;
  home.shellAliases = {
    gs = "git status";
    ai = "aichat -r %shell% -e";
  };
  editorconfig = {
    enable = true;
    settings = {
      "*".end_of_line = "lf";
      "*".insert_final_newline = true;
      "*".trim_trailing_whitespace = true;
      "*".charset = "utf-8";

      "*.{diff,patch}" = {
        end_of_line = "unset";
        insert_final_newline = "unset";
        trim_trailing_whitespace = "unset";
      };

      ".version" = {
        insert_final_newline = false;
      };

      "*.{bash,json,lock,md,nix,pl,pm,py,rb,sh,xml}" = {
        indent_style = "space";
      };

      "*.xml" = {
        indent_size = 1;
      };

      "*.{json,lock,md,nix,rb}" = {
        indent_size = 2;
      };

      "*.{bash,pl,pm,py,sh}" = {
        indent_size = 4;
      };

      "Gemfile" = {
        indent_size = 2;
        indent_style = "space";
      };

      "package.json" = {
        indent_style = "unset";
      };

      "*.{c,h}" = {
        insert_final_newline = "unset";
        trim_trailing_whitespace = "unset";
      };

      "*.{asc,key,ovpn}" = {
        insert_final_newline = "unset";
        end_of_line = "unset";
        trim_trailing_whitespace = "unset";
      };

      "*.lock" = {
        indent_size = "unset";
      };

      "*.md" = {
        trim_trailing_whitespace = true;
      };

      "*.nib" = {
        end_of_line = "unset";
        insert_final_newline = "unset";
        trim_trailing_whitespace = "unset";
        charset = "unset";
      };

      "eggs.nix" = {
        trim_trailing_whitespace = "unset";
      };

      "nixos/modules/services/networking/ircd-hybrid/*.{conf,in}" = {
        trim_trailing_whitespace = "unset";
      };

      "pkgs/build-support/dotnetenv/Wrapper/**" = {
        end_of_line = "unset";
        indent_style = "unset";
        insert_final_newline = "unset";
        trim_trailing_whitespace = "unset";
      };

      "registry.dat" = {
        end_of_line = "unset";
        insert_final_newline = "unset";
      };

      "pkgs/development/haskell-modules/hackage-packages.nix" = {
        indent_style = "unset";
        trim_trailing_whitespace = "unset";
      };

      "pkgs/misc/documentation-highlighter/**" = {
        insert_final_newline = "unset";
      };

      "pkgs/servers/dict/wordnet_structures.py" = {
        trim_trailing_whitespace = "unset";
      };

      "pkgs/tools/misc/timidity/timidity.cfg" = {
        trim_trailing_whitespace = "unset";
      };

      "pkgs/tools/virtualization/ovftool/*.ova" = {
        end_of_line = "unset";
        insert_final_newline = "unset";
        trim_trailing_whitespace = "unset";
        charset = "unset";
      };

      "lib/tests/*.plist" = {
        indent_style = "tab";
        insert_final_newline = "unset";
      };

      "pkgs/kde/generated/**" = {
        insert_final_newline = "unset";
        end_of_line = "unset";
      };
    };
  };
}
