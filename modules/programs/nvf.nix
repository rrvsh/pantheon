{ inputs, pkgs, ... }:
{
  nix.settings.substituters = [ "https://nvf.cachix.org" ];
  nix.settings.trusted-public-keys = [
    "nvf.cachix.org-1:GMQWiUhZ6ux9D5CvFFMwnc2nFrUHTeGaXRlVBXo+naI="
  ];

  home-manager.users.rafiq = {
    imports = [
      inputs.nvf.homeManagerModules.default
      ./nvf/input.nix
      ./nvf/languages.nix
      ./nvf/ui.nix
      ./nvf/utilities.nix
    ];
    home.sessionVariables.EDITOR = "nvim";
    programs.nvf = {
      enable = true;
      enableManpages = true;
      settings.vim = {
        viAlias = true;
        vimAlias = true;
        options = {
          # Indentation
          autoindent = true;
          smartindent = true;
          expandtab = true;
          smarttab = true;
          wrap = true;
          shiftwidth = 2;
          tabstop = 2;
          foldlevel = 1000; # Open all folds by default

          # Search
          hlsearch = true;
          ignorecase = true;
          incsearch = true;
          smartcase = true; # case-sensitive if search contains uppercase

          # Visual
          number = true;
          cursorline = true;
          visualbell = true;
          termguicolors = true;

          # Input
          backspace = "indent,eol,start";
        };
        keymaps = [
          {
            desc = "Open the file path under the cursor, making the file if it doesn't exist.";
            key = "gf";
            mode = "n";
            action = ":cd %:p:h<CR>:e <cfile><CR>";
            silent = true;
          }
          {
            desc = "Delete the previous word.";
            key = "<C-BS>";
            mode = "i";
            action = "<C-W>";
            silent = true;
          }
          {
            desc = "Open the filetree.";
            key = "t";
            mode = "n";
            action = ":Yazi<CR>";
            silent = true;
          }
        ];
        luaConfigRC.turn_off_inline_diagnostics =
          # lua
          ''
            vim.diagnostic.config({
              virtual_text = false -- turn off inline diagnostics
            })
          '';
        extraPlugins = with pkgs.vimPlugins; {
          yuck-vim = {
            package = yuck-vim;
          };
          nvim-treesitter-parsers = {
            package = nvim-treesitter-parsers.yuck;
          };
          nvim-parinfer = {
            package = nvim-parinfer;
          };
        };
      };
    };
  };
}
