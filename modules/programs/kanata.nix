{
  services.kanata = {
    enable = true;
    keyboards.k14 = {
      devices = [ "/dev/input/by-id/usb-Keychron_Keychron_K14-event-kbd" ];
      extraDefCfg = "process-unmapped-keys yes";
      config = # lisp
        ''
          (defsrc)

          (deflayermap (default-layer)
          ;; tap caps lock as enter, hold as left shift
          caps (tap-hold 100 100 esc lshift))
        '';
    };
  };
}
