{
  programs.nvf.settings.vim.lsp = {
    # enable is automatically set by null-ls and lspconfig options
    # enable = true;
    formatOnSave = true;
    # lightbulb shows a lightbulb when code actions are available
    # TODO: Look into code actions and how to enable them with telescope
    lightbulb = {
      enable = true;
      setupOpts = {};
    };
    # ls-signature shows a small signature for functions etc
    # TODO: Look into configuring this
    # does not work with blink cmp
    lspSignature = {
      enable = false;
      setupOpts = {};
    };
    # lspconfig should be enabled and configured automatically
    lspconfig = {
      enable = true;
      sources = {}; # strings for snippet sources?
    };
    # lspkind provides vs code like icons for signatures
    lspkind = {
      enable = true;
      setupOpts = {
        # call before lspkind modifications are applied
        before = null; # takes luainline
        # defines orders of symbols shown, e.g. text_symbol or symbol
        mode = "symbol_text";
      };
    };
    # lsplines moves diagnostics to virtual lines after the actual line
    lsplines.enable = false; # TODO: add a keymap to toggle this
    # lspsaga provides many features:
    # - breadcrumbs: provides trace to current symbol at top
    # - callhierarchy: provides a list of the call hierarchy
    # - code actions: shows a list of available code actions
    # - definition: peek or go to definitions
    # - diagnostic: jump around the diagnostics in the file and see the diagnostic in a floating window
    # - finder: search for references etc
    # - float terminal: open a floating terminal
    # - hover: opens a floating docs window
    # - implement: see interfaces
    # - lightbulb: same as lightbulb
    # - outline: see entire file outline
    # - rename: change all occurrences
    # - ui beacon: highlight the cursor
    # default keybinds:
    # - codeAction "<leader>ca"
    # - lspFinder "<leader>lf"
    # - nextDiagnostic "<leader>ln"
    # - previewDefinition "<leader>ld"
    # - previousDiagnostic "<leader>lp"
    # - rename "<leader>lr"
    # - renderHoveredDoc "<leader>lh"
    # - showCursorDiagnostics "<leader>lc"
    # - showLineDiagnostics "<leader>ll"
    # - signatureHelp "<leader>ls"
    # - smartScrollDown "<C-b>"
    # - smartScrollUp "<C-f>"
    lspsaga.enable = false;
    # null-ls exposes nvim as a language server, also used automatically
    null-ls = {
      enable = true;
      sources = {};
    };
    # nvim-docs-view provides documentation in the side panel
    nvim-docs-view = {
      enable = true;
      # default mappings:
      # - viewToggle "<leader>lvt"
      # - viewUpdate "<leader>lvu"
      mappings = {};
      setupOpts = {};
    };
    # otter-nvim allows embedding code in other documents
    otter-nvim = {
      enable = true;
      mappings.toggle = "<leader>lo"; # default
      setupOpts = {};
    };
    # trouble.nvim shows diagnostics and search results
    trouble = {
      enable = true;
      # default mappings:
      # - documentDiagnostics "<leader>ld"
      # - locList "<leader>xl"
      # - lspReferences "<leader>lr"
      # - quickfix "<leader>xq"
      # - symbols "<leader>xs"
      # - workspaceDiagnostics "<leader>lwd"
      mappings = {};
      setupOpts = {};
    };
    # default mappings for lsp:
    # - addWorkspaceFolder "<leader>lwa"
    # - codeAction "<leader>la"
    # - documentHighlight "<leader>lH"
    # - format "<leader>lf"
    # - goToDeclaration "<leader>lgD"
    # - goToDefinition "<leader>lgd"
    # - goToType "<leader>lgt"
    # - hover "<leader>lh"
    # - listDocumentSymbols "<leader>lS"
    # - listImplementations "<leader>lgi"
    # - listReferences "<leader>lgr"
    # - listWorkspaceFolders "<leader>lwl"
    # - listWorkspaceSymbols "<leader>lws"
    # - nextDiagnostic "<leader>lgn"
    # - openDiagnosticFloat "<leader>le"
    # - previousDiagnostic "<leader>lgp"
    # - removeWorkspaceFolder "<leader>lwr"
    # - renameSymbol "<leader>ln"
    # - signatureHelp "<leader>ls"
    # - toggleFormatOnSave "<leader>ltf"
  };
}
