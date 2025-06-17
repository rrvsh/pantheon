{ lib, pkgs, ... }:
let
  inherit (lib) singleton replicate;
  inherit (lib.strings)
    concatMapStringsSep
    removeSuffix
    concatStrings
    stringAsChars
    ;
  inherit (lib.attrsets) mapAttrsToList;
  inherit (pkgs) writeTextFile;
  indent =
    n: s:
    let
      indentString = concatStrings (replicate n " ");
      sep = "\n" + indentString;
    in
    indentString + stringAsChars (c: if c == "\n" then sep else c) (removeSuffix "\n" s);

in
{
  home.sessionVariables.EDITOR = "nvim";
  persistDirs = singleton ".local/share/nvf";
  programs.nvf.enable = true;
  programs.nvf.settings.vim = {
    startPlugins =
      [ pkgs.pantheon.snippets ]
      ++ (mapAttrsToList
        (
          name: value:
          writeTextFile {
            name = "${name}.snippets";
            text = concatMapStringsSep "\n" (x: ''
              snippet ${x.trigger} ${x.description}
              ${indent 2 x.body}
            '') value;
            destination = "/snippets/${name}.snippets";
          }
        )
        {
          all = [
            {
              trigger = "if";
              description = "";
              body = "if $1 else $2";
            }
          ];
          nix = [
            {
              trigger = "mkOption";
              description = "";
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
        }
      );

    hideSearchHighlight = true;
    syntaxHighlighting = true;
    telescope.enable = true;
    searchCase = "ignore";
    undoFile.enable = true;
    fzf-lua.enable = true;
    git.enable = true;
    git.gitsigns.enable = false;
    autopairs.nvim-autopairs.enable = true;
    autocomplete = import ./_nvf/autocomplete.nix { inherit lib; };
    binds = import ./_nvf/binds.nix;
    clipboard = import ./_nvf/clipboard.nix;
    diagnostics = import ./_nvf/diagnostics.nix;
    keymaps = import ./_nvf/keymaps.nix;
    languages = import ./_nvf/languages.nix;
    lsp = import ./_nvf/lsp.nix;
    navigation = import ./_nvf/navigation.nix;
    notes = import ./_nvf/notes.nix;
    options = import ./_nvf/options.nix;
    notify = import ./_nvf/notify.nix;
    snippets = import ./_nvf/snippets.nix { inherit pkgs; };
    statusline = import ./_nvf/statusline.nix;
    treesitter = import ./_nvf/treesitter.nix;
    ui = import ./_nvf/ui.nix;
    utility = import ./_nvf/utility.nix;
    visuals = import ./_nvf/visuals.nix;
  };
}
