{ lib, stdenv, fetchzip }:

stdenv.mkDerivation {
  pname = "ipaexfont";
  version = "4.01";

  src = fetchzip {
    url = "https://moji.or.jp/wp-content/ipafont/IPAexfont/IPAexfont00401.zip";
    hash = "sha256-/87qJIb+v4qrtDy+ApfXxh59reOk+6RhGqFN98mc+8Q=";
  };

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    install -D -m 644 -t "$out/share/fonts/truetype" *.ttf
  '';

  outputHashMode = "recursive";
  outputHash = "sha256-11NYDZ3umJqU+oqkfJgrmNHb5nJmOM0ShuAmhCZ+fb4=";

  meta = with lib; {
    description = "Japanese font package with Mincho and Gothic fonts";
    longDescription = ''
      IPAex font is a Japanese font developed by the Information-technology
      Promotion Agency of Japan. It provides both Mincho and Gothic fonts,
      suitable for both display and printing.

      This is the successor to the IPA fonts.
    '';
    homepage = "https://moji.or.jp/ipafont/";
    license = licenses.ipa;
    maintainers = with maintainers; [ gebner ];
  };
}
