{ lib }:
{
  blink-cmp = {
    enable = true;
    friendly-snippets.enable = true;
    sourcePlugins.ripgrep.enable = true;
    setupOpts = {
      # Disable completion in markdown files
      # TODO: Disable completion when in comments
      enabled =
        lib.generators.mkLuaInline
          # lua
          ''
            function()
              return not vim.tbl_contains({"markdown"}, vim.bo.filetype)
                and vim.bo.buftype ~= "prompt"
                and vim.b.completion ~= false
            end
          '';
      completion.documentation.auto_show_delay_ms = 0;
      # Show e.g. function parameters
      signature.enabled = true;
    };
  };
}
