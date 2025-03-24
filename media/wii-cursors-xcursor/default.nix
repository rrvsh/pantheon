{
  lib,
  stdenv,
}:

stdenv.mkDerivation {
  pname = "wii-cursor";
  version = "1.0";
  src = ./.;

  installPhase = ''
    mkdir -p $out/share/icons/wii-cursor
    install -Dm 0644 index.theme $out/share/icons/wii-cursor/index.theme
    install -Dm 0755 -t $out/share/icons/wii-cursor/cursors cursors/*
  '';

  meta = with lib; {
    description = "Wii Cursor";
    homepage = "https://github.com/ful1e5/apple_cursor";
    license = [
      licenses.gpl3Only
    ];
    platforms = platforms.linux;
  };
}
