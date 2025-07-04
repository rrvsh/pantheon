{ pkgs, inputs, ... }:
{
  imports = [ inputs.nix-index-database.hmModules.nix-index ];
  programs = {
    tealdeer.enable = true;
    tealdeer.enableAutoUpdates = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    zoxide.enable = true;
    nix-index.enable = true;
    nix-index-database.comma.enable = true;
  };
  persistDirs = [ ".local/share/zoxide" ];
  home = {
    shellAliases = {
      windows = "sudo systemctl reboot --boot-loader-entry=auto-windows";
      v = "$EDITOR";
      e = "edit";
      cd = "z"; # zoxide
      ai = "aichat -r %shell% -e";
    };
    packages = with pkgs; [
      ripgrep
      aichat
      pantheon.rebuild
      pantheon.deploy
      pantheon.edit
      pantheon.commit
    ];
  };
  xdg.configFile."aichat/config.yaml".text = ''
    model: gemini:gemini-2.0-flash
    clients:
    - type: gemini
  '';
}
