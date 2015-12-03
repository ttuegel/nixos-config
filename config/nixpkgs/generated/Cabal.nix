{ mkDerivation, array, base, binary, bytestring, containers
, deepseq, directory, extensible-exceptions, filepath, old-time
, pretty, process, QuickCheck, regex-posix, stdenv, tasty
, tasty-hunit, tasty-quickcheck, time, unix
}:
mkDerivation {
  pname = "Cabal";
  version = "1.23.0.1";
  src = /home/ttuegel/hs/cabal/Cabal;
  libraryHaskellDepends = [
    array base binary bytestring containers deepseq directory filepath
    pretty process time unix
  ];
  testHaskellDepends = [
    base bytestring containers directory extensible-exceptions filepath
    old-time pretty process QuickCheck regex-posix tasty tasty-hunit
    tasty-quickcheck unix
  ];
  homepage = "http://www.haskell.org/cabal/";
  description = "A framework for packaging Haskell software";
  license = stdenv.lib.licenses.bsd3;
}
