{ lib }:
{
  blink-cmp = {
    enable = true;
    friendly-snippets.enable = true;
    sourcePlugins = {
      ripgrep.enable = true;
    };
    setupOpts = {
      completion.documentation.auto_show_delay_ms = 0;
      signature.enabled = true;
      enabled =
        lib.generators.mkLuaInline
          # lua
          ''
            --- Disable completion for markdown
            function()
              return not vim.tbl_contains({"markdown"}, vim.bo.filetype)
                and vim.bo.buftype ~= "prompt"
                and vim.b.completion ~= false
            end
          '';
      cmdline = {
        enabled = true;
        sources = null;
        completion.menu.auto_show = false;
      };
    };
  };
}
