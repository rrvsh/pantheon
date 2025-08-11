{
  lib,
  inputs,
  moduleWithSystem,
  ...
}:
let
  inherit (lib.strings) concatStrings;
  inherit (lib.meta) getExe;
in
{
  flake.modules.homeManager.rafiq = moduleWithSystem (
    { inputs', ... }:
    { pkgs, ... }:
    {
      imports = [
        inputs.nvf.homeManagerModules.default
        inputs.nix-index-database.hmModules.nix-index
      ];
      persistDirs = [
        ".local/share/zoxide"
        "notebook"
      ];
      home = {
        sessionVariables = {
          EDITOR = "nvim";
          FETCH = "hyfetch";
          FILE_BROWSER = "yazi";
          SHELL = "fish";
          GEMINI_MODEL = "gemini-2.5-flash";
        };
        shellAliases = {
          fetch = "hyfetch";
          windows = "sudo systemctl reboot --boot-loader-entry=auto-windows";
          v = "$EDITOR";
          e = "edit";
          cd = "z"; # zoxide
          ai = "gemini -m gemini-2.5-flash-lite -p";
        };
        packages = with pkgs; [
          fastfetch
          ripgrep
          (import ./_scripts/edit.nix { inherit pkgs; })
          (import ./_scripts/commit.nix { inherit pkgs lib; })
          (import ./_scripts/note.nix { inherit pkgs; })
          (import ./_scripts/rebuild.nix { inherit pkgs; })
        ];
      };
      programs = {
        gemini-cli = {
          enable = true;
          package = inputs'.nixpkgs-master.legacyPackages.gemini-cli;
          settings = {
            theme = "Default";
            preferredEditor = "nvim";
            autoAccept = true;
            checkpointing.enabled = true;
          };
        };
        mise.enable = true;
        nvf.enable = true;
        nvf.settings.vim = {
          syntaxHighlighting = true;
          hideSearchHighlight = true;
          searchCase = "ignore";
          undoFile.enable = true;
          telescope.enable = true;
          fzf-lua.enable = true;
          git.enable = true;
          autopairs.nvim-autopairs.enable = true;
          autocomplete = import ./_nvf/autocomplete.nix { inherit lib; };
          binds = import ./_nvf/binds.nix;
          languages = import ./_nvf/languages.nix;
          lsp = import ./_nvf/lsp.nix;
          navigation = import ./_nvf/navigation.nix;
          notes.todo-comments.enable = true;
          options = {
            autoindent = true;
            backspace = "indent,eol,start";
            cursorline = true;
            expandtab = true;
            shiftwidth = 2;
            smartindent = true;
            tabstop = 2;
          };
          snippets = import ./_nvf/snippets.nix { inherit pkgs; };
          statusline = import ./_nvf/statusline.nix;
          treesitter = {
            autotagHtml = true;
            fold = true;
            indent.disable = [ "markdown" ];
            textobjects.enable = true;
          };
          ui = import ./_nvf/ui.nix;
          utility = import ./_nvf/utility.nix;
          visuals = import ./_nvf/visuals.nix;
        };
        zk = {
          enable = true;
          settings.notebook.dir = "~/notebook";
        };
        hyfetch = {
          enable = true;
          settings = {
            preset = "bisexual";
            mode = "rgb";
            light_dark = "dark";
            lightness = 0.5;
            color_align = {
              # Flag color alignment
              mode = "horizontal";
              fore_back = null;
            };
            backend = "fastfetch";
          };
        };

        tealdeer.enable = true;
        tealdeer.enableAutoUpdates = true;
        direnv = {
          enable = true;
          nix-direnv.enable = true;
        };
        zoxide.enable = true;
        nix-index.enable = true;
        nix-index-database.comma.enable = true;
        fzf.enable = true;
        fzf.enableZshIntegration = true;
        fzf.defaultCommand = "${getExe pkgs.fd} --type f --strip-cwd-prefix";
        yazi = {
          enable = true;
          shellWrapperName = "t";
          settings.mgr.sort_by = "natural";
        };
        fish.enable = true;
        fish.shellInit = # fish
          ''
            function envsource
              for line in (cat $argv | grep -v '^#')
                set item (string split -m 1 '=' $line)
                set -gx $item[1] $item[2]
                echo "Exported key $item[1]"
              end
            end
          '';
        starship = {
          enable = true;
          settings = {
            add_newline = false;
            format = concatStrings [
              # First Line
              ## Left Prompt
              "$hostname$directory"
              "$fill"
              ## Right Prompt
              "$all"
              # Second Line
              ## Left Prompt
              "$character"
            ];
            git_branch.format = "[$symbol$branch(:$remote_branch)]($style) ";
            shlvl.disabled = false;
            username.disabled = true;
            fill.symbol = " ";
          };
        };
      };
    }
  );
}
