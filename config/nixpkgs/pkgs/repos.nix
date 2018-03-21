{ mkDerivation, base, bytestring, containers, dhall, fetchgit
, optparse-applicative, stdenv, system-filepath, text, text-format
, trifecta, turtle, unix, vector
}:
mkDerivation {
  pname = "repos";
  version = "0.1";
  src =
    let lock = builtins.fromJSON (builtins.readFile ./repos.lock.json); in
    fetchgit {
      inherit (lock) url sha256 rev;
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
