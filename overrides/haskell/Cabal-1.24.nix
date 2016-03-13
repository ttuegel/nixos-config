{ mkDerivation, array, base, binary, bytestring, containers
, deepseq, directory, filepath, old-time, pretty, process
, QuickCheck, regex-posix, stdenv, tagged, tasty, tasty-hunit
, tasty-quickcheck, time, transformers, unix
}:
mkDerivation {
  pname = "Cabal";
  version = "1.24.0.0";
  src = ./cabal/Cabal;
  libraryHaskellDepends = [
    array base binary bytestring containers deepseq directory filepath
    pretty process time unix
  ];
  testHaskellDepends = [
    base bytestring containers directory filepath old-time pretty
    process QuickCheck regex-posix tagged tasty tasty-hunit
    tasty-quickcheck transformers unix
  ];
  homepage = "http://www.haskell.org/cabal/";
  description = "A framework for packaging Haskell software";
  license = stdenv.lib.licenses.bsd3;
}
