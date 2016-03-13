{ mkDerivation, base, base64-bytestring, bytestring, Cabal
, containers, cryptohash, directory, ed25519, filepath, ghc-prim
, HUnit, mtl, network, network-uri, parsec, stdenv, tar, tasty
, tasty-hunit, template-haskell, temporary, time, transformers
, zlib
}:
mkDerivation {
  pname = "hackage-security";
  version = "0.5.0.2";
  src = ./hackage-security/hackage-security;
  libraryHaskellDepends = [
    base base64-bytestring bytestring Cabal containers cryptohash
    directory ed25519 filepath ghc-prim mtl network network-uri parsec
    tar template-haskell time transformers zlib
  ];
  testHaskellDepends = [
    base bytestring Cabal containers HUnit network-uri tar tasty
    tasty-hunit temporary time zlib
  ];
  homepage = "https://github.com/well-typed/hackage-security";
  description = "Hackage security library";
  license = stdenv.lib.licenses.bsd3;
}
