{
  programs.firefox = {
    enable = true;
    profiles.rafiq.id = 0;
    profiles.test.id = 1;
  };
  home.persistence."/persist/home/rafiq".directories = [ ".mozilla/firefox" ];
}
