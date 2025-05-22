{ config, lib, ... }:
{
  config = lib.mkIf (config.cli.editor == "nvf") {
    home.sessionVariables.EDITOR = "nvim";
    home.persistence."/persist/home/${config.snowfallorg.user.name}".directories = [
      ".local/share/nvf"
    ];
    programs.nvf = {
      enable = true;
      settings.vim = {
        hideSearchHighlight = true;
        undoFile.enable = true;
        fzf-lua.enable = true;
        git.enable = true;
        autocomplete = import ./autocomplete.nix { inherit lib; };
        autopairs.nvim-autopairs.enable = true;
        binds = import ./binds.nix;
        clipboard = import ./clipboard.nix;
        diagnostics = import ./diagnostics.nix;
        keymaps = import ./keymaps.nix;
        languages = import ./languages.nix;
        lsp = import ./lsp.nix;

        options = import ./options.nix;
        notify = import ./notify.nix;
        utility = import ./utility.nix;
        visuals = import ./visuals.nix;
      };
    };
  };
}
