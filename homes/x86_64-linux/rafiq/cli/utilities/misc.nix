{ inputs, pkgs, ... }:
{
  programs = {
    nh.enable = true;
    pay-respects.enable = true;
    tealdeer = {
      enable = true;
      enableAutoUpdates = true;
      settings.updates.auto_update = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    starship = {
      enable = true;
      settings = {
        add_newline = false;
        format = ''
          $directory$character
        '';
        right_format = ''
          $all
        '';
        git_branch.format = "[$symbol$branch(:$remote_branch)]($style) ";
        shlvl.disabled = false;
        hostname.disabled = true;
        username.disabled = true;
      };
    };
  };
  home = {
    shellAliases = {
      v = "nvim";
      e = "edit";
      cd = "z";
      ai = "aichat -r %shell% -e";
    };
    packages = with pkgs; [
      aichat
      devenv
      pantheon.rebuild
      pantheon.deploy
      pantheon.edit
      pantheon.commit
      pantheon.check
      inputs.nixspect.packages."x86_64-linux".nixspect
    ];
  };

  xdg.configFile."aichat/config.yaml".text = ''
    model: gemini:gemini-2.0-flash
    clients:
    - type: gemini
  '';
}
