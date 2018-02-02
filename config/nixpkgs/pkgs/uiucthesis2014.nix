{ stdenv, texlive, fetchFromGitHub }:

stdenv.mkDerivation {
  name = "uiucthesis2014-2.25b";

  src = fetchFromGitHub {
    owner = "mayhewsw";
    repo = "uiucthesis2014";
    rev = "0b52c9013af0ff48e347e2c1b8b917640e93eed1";
    sha256 = "1vc0pknq3sb2wbhapdys13qraa0w4h3lj9npfxk61gjj91ff1l27";
  };

  buildInputs = [ texlive.combined.scheme-basic ];

  buildPhase = ''
    make files
  '';

  installPhase = ''
    mkdir -p "$out/tex/latex/uiucthesis2014"
    install -t "$out/tex/latex/uiucthesis2014" \
        uiucthesis2014.cls uiucthesis2014.sty
  '';
}
