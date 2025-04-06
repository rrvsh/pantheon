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
            home-row-hold-timeout 200
            tt $tap-timeout
            hrht $home-row-hold-timeout
          )

          (deflayermap (base)
            ;; tap caps lock as enter, hold as left ctrl
            ;; tap-hold-release will activate the hold action early
            ;; if another key is pressed while it is held.
            CapsLock (tap-hold-release 200 200 Escape ControlLeft)
          )
        '';
    };
  };
}
