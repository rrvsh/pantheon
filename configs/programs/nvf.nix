{
  home-manager.users.rafiq = {
    imports = [
      ./nvf/input.nix
      ./nvf/languages.nix
      ./nvf/ui.nix
      ./nvf/utilities.nix
    ];
  };
}
