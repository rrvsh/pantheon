{
  programs.nvf.settings.vim.debugger.nvim-dap = {
    # nvim-dap enables debugging
    # you can set breakpoints and step through code or use a REPL
    enable = true;
    mappings = {
      # default mappings:
      # - Continue:<leader>dc
      # - Go down stacktrace:<leader>dvi
      # - Go up stacktrace:<leader>dvo
      # - Hover:<leader>dh
      # - Restart:<leader>dR
      # - Re-run Last Debug Session:<leader>d.
      # - Continue to the current cursor:<leader>dgc
      # - Step back:<leader>dgk
      # - Step into function:<leader>dgi
      # - Step out of function:<leader>dgo
      # - Next step:<leader>dgj
      # - Terminate:<leader>dq
      # - Toggle breakpoint:<leader>db
      # - Toggle DAP-UI:<leader>du
      # - Toggle Repl:<leader>dr
    };
    # list of debuggers to install
    sources = {};
    # install nvim-dap-ui which provides a debugging ui
    ui = {
      enable = true;
      setupOpts = {};
    };
  };
}
