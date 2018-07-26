{ mkDerivation, base, bytestring, Cabal, containers, criterion
, deepseq, Diff, directory, exceptions, fetchgit, filepath
, ghc-prim, haskell-src-exts, hspec, monad-loops, mtl
, optparse-applicative, path, path-io, stdenv, text, transformers
, unix-compat, utf8-string, yaml
}:
mkDerivation {
  pname = "hindent";
  version = "5.2.7";
  src = fetchgit {
    url = "https://github.com/ttuegel/hindent.git";
    sha256 = "0xfw39c15v86yidaiyrpnvw090mhnbywy3hksszdab9gfpg9bvfh";
    rev = "5c4984c49cb9a610bcf74c391bafdcd9e8354029";
  };
  isLibrary = true;
  isExecutable = true;
  enableSeparateDataOutput = true;
  libraryHaskellDepends = [
    base bytestring Cabal containers directory exceptions filepath
    haskell-src-exts monad-loops mtl text transformers utf8-string yaml
  ];
  executableHaskellDepends = [
    base bytestring deepseq directory exceptions ghc-prim
    haskell-src-exts optparse-applicative path path-io text
    transformers unix-compat utf8-string yaml
  ];
  testHaskellDepends = [
    base bytestring deepseq Diff directory exceptions haskell-src-exts
    hspec monad-loops mtl utf8-string
  ];
  benchmarkHaskellDepends = [
    base bytestring criterion deepseq directory exceptions ghc-prim
    haskell-src-exts utf8-string
  ];
  homepage = "https://github.com/commercialhaskell/hindent";
  description = "Extensible Haskell pretty printer";
  license = stdenv.lib.licenses.bsd3;
}
