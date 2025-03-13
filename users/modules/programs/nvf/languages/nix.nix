{pkgs, ...}: {
  home.packages = [pkgs.nixd];
  programs.nvf.settings.vim.languages.nix = {
    enable = true;
    # lsp = {
    #   server = "nixd";
    #   options = {
    #     nixpkgs.expr = ''(builtins.getFlake ("git+file://" + toString ./.)).inputs.nixpkgs'';
    #     options.nixos.expr = ''(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.${builtins.getEnv "HOSTNAME"}.options'';
    #   };
    # };
  };
}
