{ mkDerivation, array, base, binary, bytestring, containers
, deepseq, directory, extensible-exceptions, filepath, old-time
, pretty, process, QuickCheck, regex-posix, stdenv, tasty
, tasty-hunit, tasty-quickcheck, time, unix
}:
mkDerivation {
  pname = "Cabal";
  version = "1.23.0.0";
  src = /home/ttuegel/hs/cabal/Cabal;
  buildDepends = [
    array base binary bytestring containers deepseq directory filepath
    pretty process time unix
  ];
  testDepends = [
    base bytestring containers directory extensible-exceptions filepath
    old-time process QuickCheck regex-posix tasty tasty-hunit
    tasty-quickcheck unix
  ];
  preCheck = "unset GHC_PACKAGE_PATH; export HOME=$NIX_BUILD_TOP";
  homepage = "http://www.haskell.org/cabal/";
  description = "A framework for packaging Haskell software";
  license = stdenv.lib.licenses.bsd3;
}
