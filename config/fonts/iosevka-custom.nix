{ stdenv, set, src }:

stdenv.mkDerivation {
  name = "iosevka-${set}";
  inherit src;

  configurePhase = "true";
  buildPhase = "true";
  installPhase = ''
    fontdir=$out/share/fonts/iosevka-${set}
    install -d $fontdir
    install ttf/*.ttf $fontdir
  '';
}
