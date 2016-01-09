{ mkDerivation, array, async, base, bytestring, Cabal, containers
, directory, filepath, HTTP, mtl, network, network-uri, pretty
, process, QuickCheck, random, stdenv, stm, tagged, tasty
, tasty-hunit, tasty-quickcheck, time, unix, zlib
}:
mkDerivation {
  pname = "cabal-install";
  version = "1.23.0.0";
  src = /home/ttuegel/hs/cabal/cabal-install;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    array base bytestring Cabal containers directory filepath HTTP mtl
    network network-uri pretty process random stm time unix zlib
  ];
  testHaskellDepends = [
    array async base bytestring Cabal containers directory filepath
    HTTP mtl network network-uri pretty process QuickCheck random stm
    tagged tasty tasty-hunit tasty-quickcheck time unix zlib
  ];
  postInstall = ''
    mkdir $out/etc
    mv bash-completion $out/etc/bash_completion.d
  '';
  homepage = "http://www.haskell.org/cabal/";
  description = "The command-line interface for Cabal and Hackage";
  license = stdenv.lib.licenses.bsd3;
}
