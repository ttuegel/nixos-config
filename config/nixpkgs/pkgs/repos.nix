{ mkDerivation, base, bytestring, containers, dhall, fetchgit
, optparse-applicative, stdenv, system-filepath, text, text-format
, trifecta, turtle, unix, vector
}:
mkDerivation {
  pname = "repos";
  version = "0.1";
  src = fetchgit {
    url = "https://github.com/ttuegel/repos.git";
    sha256 = "0265349xgx8wqd1ripb1lqjyzh1qv53dn858kmcsnp52lgwdxf8p";
    rev = "3a78f426903c2680b923018dca90f977085dfdf1";
  };
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    base bytestring containers dhall optparse-applicative
    system-filepath text text-format trifecta turtle unix vector
  ];
  license = stdenv.lib.licenses.unfree;
  hydraPlatforms = stdenv.lib.platforms.none;
}
