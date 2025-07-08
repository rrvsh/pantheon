{ lib, inputs, ... }:
let
  inherit (lib.strings) concatStrings;
in
{
  flake.modules.homeManager.rafiq =
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
      xdg.configFile."aichat/config.yaml".text = ''
        model: gemini:gemini-2.0-flash
        clients:
        - type: gemini
      '';
      home = {
        sessionVariables = {
          EDITOR = "nvim";
          FETCH = "hyfetch";
          FILE_BROWSER = "yazi";
          SHELL = "fish";
        };
        shellAliases = {
          fetch = "hyfetch";
          windows = "sudo systemctl reboot --boot-loader-entry=auto-windows";
          v = "$EDITOR";
          e = "edit";
          cd = "z"; # zoxide
          ai = "aichat -r %shell% -e";
        };
        packages = with pkgs; [
          fastfetch
          ripgrep
          aichat
          (import ./_scripts/edit.nix { inherit pkgs; })
          (import ./_scripts/commit.nix { inherit pkgs; })
          (import ./_scripts/note.nix { inherit pkgs; })
          (import ./_scripts/rebuild.nix { inherit pkgs; })
        ];
      };
      programs = {
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
        yazi = {
          enable = true;
          shellWrapperName = "t";
          settings.mgr.sort_by = "natural";
        };
        fish.enable = true;
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
    };
}
