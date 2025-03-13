{
  programs.nvf.settings.vim = {
    visuals = {
      # fidget.nvim shows messages in the bottom right
      fidget-nvim = {
        enable = true;
        setupOpts = {};
      };
      # highlight-undo.nvim highlights what text was changed when performing an action that modifies the buffer while not in insert mode
      highlight-undo = {
        enable = true;
        setupOpts = {
          duration = 100; # in ms
        };
      };
      # indent-blankline.nvim adds indentation guides
      indent-blankline = {
        enable = true;
        setupOpts = {};
      };
      # nvim-cursorline provides cursor word and line highlighting
      nvim-cursorline = {
        enable = true;
        setupOpts = {
          cursorword.enable = true;
          cursorline.enable = false;
        };
      };
      nvim-scrollbar.enable = true;
      rainbow-delimiters.enable = true;
      nvim-web-devicons.enable = true;
      tiny-devicons-auto-colors.enable = true;
    };
    statusline.lualine = {
      enable = true;
    };
    tabline.nvimBufferline = {
      enable = true;
      mappings = {
        # default mappings:
        # - Close buffer:null
        # - Next buffer:<leader>bn
        # - Previous buffer:<leader>bp
        # - Move next buffer:<leader>bmn
        # - Move previous buffer:<leader>bmp
        # - Pick buffer:<leader>bc
        # - Sort buffers by directory:<leader>bsd
        # - Sort buffers by extension:<leader>bse
        # - Sort buffers by ID:<leader>bsi
        closeCurrent = "<C-w>";
        # TODO: check these mappigns
        # cycleNext = "<C-Tab>";
        # cyclePrevious = "<C-Shift-Tab>";
      };
      setupOpts = {};
    };
    # treesitter handles syntax highlighting
    treesitter = {
      enable = true;
      autotagHtml = true;
      fold = true;
      # provide context for current scope
      context = {
        enable = true;
        setupOpts = {
          mode = "topline";
        };
      };
      mappings.incrementalSelection = {
        # - Decrement selection by node [treesitter]:grm
        # - Increment selection by node [treesitter]:grn
        # - Increment selection by scope [treesitter]:grc
        # - Init selection [treesitter]:gnn
      };
    };
    git = {
      enable = true;
      # gitsigns indicates added, changed, deleted lines among other things
      gitsigns.mappings = {
        # - Blame line [Gitsigns]:<leader>hb
        # - Diff project [Gitsigns]:<leader>hD
        # - Diff this [Gitsigns]:<leader>hd
        # - Next hunk [Gitsigns]:]c
        # - Preview hunk [Gitsigns]:<leader>hP
        # - Previous hunk [Gitsigns]:[c
        # - Reset buffer [Gitsigns]:<leader>hR
        # - Reset hunk [Gitsigns]:<leader>hr
        # - Stage buffer [Gitsigns]:<leader>hS
        # - Stage hunk [Gitsigns]:<leader>hs
        # - Toggle blame [Gitsigns]:<leader>tb
        # - Toggle deleted [Gitsigns]:<leader>td
        # - Undo stage hunk [Gitsigns]:<leader>hu
      };
      # git-conflict visualises git conflicts and resolves
      git-conflict.mappings = {
        # Default mappings:
        # - Choose Both [Git-Conflict]:<leader>cb
        # - Go to the next Conflict [Git-Conflict]:[x
        # - Choose None [Git-Conflict]:<leader>c0
        # - Choose Ours [Git-Conflict]:<leader>co
        # - Go to the previous Conflict [Git-Conflict]:]x
        # - Choose Theirs [Git-Conflict]:<leader>ct
      };
      # vim-fugitive provides git cmds
    };
    dashboard.alpha.enable = true;
    notify.nvim-notify.enable = true;
    ui = {
      borders.enable = true; # TODO: enable plugin specific
      breadcrumbs.enable = true;
      breadcrumbs.navbuddy.enable = true; # nvim-navic
      # nvim-colorizer highlights color codes
      colorizer.enable = true; # TODO: check if it works
      # fastaction.nvim overrides vim.ui.select with fast action
      # TODO: look into this
      fastaction.enable = true;
      # vim-illuminate highlights all occurrences
      illuminate.enable = true; # TOOD: check if neotree is covered
      # modes-nvim colors the whole line
      modes-nvim.enable = true;
      # noice displays the command window in a floating window and disables the cmd line
      # TODO: look at the options
      noice.enable = true;
      # nvim-ufo makes folds look nicer
      nvim-ufo.enable = true;
      # smartcolumn enables line length indicators
      smartcolumn.enable = true;
    };
  };
}
