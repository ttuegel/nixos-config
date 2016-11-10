{ stdenv, fetchurl }:

let
  dfVersion = "0.43.03";
in
stdenv.mkDerivation {
  name = "gemset-${dfVersion}";
  passthru = { inherit dfVersion; };
  src = fetchurl {
    url = "https://github.com/DFgraphics/GemSet/archive/43.03.tar.gz";
    sha256 = "1fhi976qpvqc9m6nq1idgzbihmlz8b7zyawns88yinq3hgmibkvb";
  };
  configurePhase = "runHook preConfigure; runHook postConfigure;";
  buildPhase = "runHook preBuild; runHook postBuild;";
  installPhase = ''
    mkdir "$out"
    mv data "$out"
    mv raw "$out"
  '';
}
