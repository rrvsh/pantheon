{ config, ... }:
{
  # text.readme = {
  #
  # };

  perSystem =
    { pkgs, ... }:
    {
      files.files = [
        {
          path_ = "README.md";
          drv =
            pkgs.writeText "README.md" # config.text.readme
              ''
                test README
              '';
        }
      ];
    };
}
