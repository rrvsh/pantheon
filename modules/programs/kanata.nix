{
  services.kanata = {
    enable = true;
    keyboards.k14 = {
      devices = [ "/dev/input/by-id/usb-Keychron_Keychron_K14-event-kbd" ];
      extraDefCfg = "process-unmapped-keys yes";
      config = # lisp
        ''
          (defsrc)

          (defvar
            tap-timeout 200
            hold-timeout 200
            tt $tap-timeout
            ht $hold-timeout
          )

          (deflayermap (default-layer)
            ;; tap caps lock as enter, hold as left ctrl
            caps (tap-hold-release $tt $ht esc lctl)
            Space (tap-dance $ht (Space return))
          )
        '';
    };
  };
}
