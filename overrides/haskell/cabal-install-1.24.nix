{ mkDerivation, array, async, base, binary, bytestring, Cabal
, containers, directory, filepath, hackage-security, hashable, HTTP
, mtl, network, network-uri, pretty, process, QuickCheck, random
, regex-posix, stdenv, stm, tagged, tar, tasty, tasty-hunit
, tasty-quickcheck, time, unix, zlib
}:
mkDerivation {
  pname = "cabal-install";
  version = "1.24.0.0";
  src = ./cabal/cabal-install;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    array base binary bytestring Cabal containers directory filepath
    hackage-security hashable HTTP mtl network network-uri pretty
    process random stm tar time unix zlib
  ];
  testHaskellDepends = [
    array async base binary bytestring Cabal containers directory
    filepath hackage-security hashable HTTP mtl network network-uri
    pretty process QuickCheck random regex-posix stm tagged tar tasty
    tasty-hunit tasty-quickcheck time unix zlib
  ];
  postInstall = ''
    mkdir $out/etc
    mv bash-completion $out/etc/bash_completion.d
  '';
  homepage = "http://www.haskell.org/cabal/";
  description = "The command-line interface for Cabal and Hackage";
  license = stdenv.lib.licenses.bsd3;
}
