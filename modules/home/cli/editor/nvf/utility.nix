{
  direnv.enable = true;
  leetcode-nvim.enable = true;
  mkdir.enable = true;
  motion.leap.enable = true;
  motion.leap.mappings.leapForwardTo = "s";
  motion.leap.mappings.leapBackwardTo = "S";
  vim-wakatime.enable = true;
  yazi-nvim = {
    enable = true;
    mappings = {
      openYazi = "t";
      openYaziDir = "T";
    };
    setupOpts.open_for_directories = true;
  };
}
