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

            ;; space if pressed twice in quick succession will
            ;; enter a space then delete it and put enter
            Space (tap-hold-release 200 200
                    (tap-dance-eager 200 (
                      (macro Space) ;; use macro to prevent auto repeat
                      (macro Backspace Enter)
                    ))
                    (layer-while-held num)
                  )

            ;; Home Row Mods
            KeyA (tap-hold-release $tt $hrht KeyA ControlLeft)
            KeyS (tap-hold-release $tt $hrht KeyS ShiftLeft)
            KeyD (tap-hold-release $tt $hrht KeyD AltLeft)
            KeyF (tap-hold-release $tt $hrht KeyF MetaLeft)

            Semicolon (tap-hold-release $tt $hrht Semicolon ControlRight)
            KeyL (tap-hold-release $tt $hrht KeyL ShiftRight)
            KeyK (tap-hold-release $tt $hrht KeyK AltRight)
            KeyJ (tap-hold-release $tt $hrht KeyJ MetaRight)
            ;; Pressing JKLA + Space will result in s being s
          )

          (deflayermap (num)
            KeyA Digit1
            KeyS Digit2
            KeyD Digit3
            KeyF Digit4
            KeyG Digit5
            KeyH Digit6
            KeyJ Digit7
            KeyK Digit8
            KeyL Digit9
            Semicolon Digit0
          )
        '';
    };
  };
}
