{ mkDerivation, base, bytestring, containers, deepseq, descriptive
, Diff, directory, exceptions, ghc-prim, haskell-src-exts, hspec
, monad-loops, mtl, path, path-io, stdenv, text, transformers
, unix-compat, utf8-string, yaml
}:
mkDerivation {
  pname = "hindent";
  version = "5.2.1";
  sha256 = "0lqwn2v7fwp9873i399grnd92dgdsrmvgg4wmbgskgl7y361hc8c";
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    base bytestring containers exceptions haskell-src-exts monad-loops
    mtl text transformers utf8-string yaml
  ];
  executableHaskellDepends = [
    base bytestring deepseq descriptive directory exceptions ghc-prim
    haskell-src-exts path path-io text transformers unix-compat
    utf8-string yaml
  ];
  testHaskellDepends = [
    base bytestring deepseq Diff directory exceptions haskell-src-exts
    hspec monad-loops mtl utf8-string
  ];
  homepage = "http://www.github.com/chrisdone/hindent";
  description = "Extensible Haskell pretty printer";
  license = stdenv.lib.licenses.bsd3;
}
