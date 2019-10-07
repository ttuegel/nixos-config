{ stdenv, sources, texlive, fetchFromGitHub }:

stdenv.mkDerivation {
  name = "uiucthesis2014-2.25b";

  src = sources."uiucthesis2014";

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
