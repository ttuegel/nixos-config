{ pkgs, lib, config, ... }:

let
  inherit (pkgs) stdenv;
  cabalConfig =
    stdenv.mkDerivation {
      name = "cabal.config";
      phases = "buildPhase";
      buildInputs = with pkgs; [ openblasCompat zlib ];
      preHook = ''
        declare -a cabalExtraLibDirs cabalExtraIncludeDirs
        cabalConfigLocalEnvHook() {
            if [ -d "$1/include" ]; then
                cabalExtraIncludeDirs+=("$1/include")
            fi
            if [ -d "$1/lib" ]; then
                cabalExtraLibDirs+=("$1/lib")
            fi
        }
        envHooks+=(cabalConfigLocalEnvHook)
      '';
      buildPhase = ''
        eval $shellHook
        cat >"$out" <<EOF
        extra-lib-dirs: ''${cabalExtraLibDirs[@]}
        extra-include-dirs: ''${cabalExtraIncludeDirs[@]}

        program-locations
          ar-location: $(type -P ar)
          gcc-location: $(type -P gcc)
          ld-location: $(type -P ld)
          strip-location: $(type -P strip)
          tar-location: $(type -P tar)
        EOF
      '';
    };
  haskellPackages = pkgs.haskellPackages.override {
    overrides = self: super: {
      Cabal = self.callPackage
        (
          { mkDerivation, array, base, base-compat, base-orphans, binary
          , bytestring, containers, deepseq, Diff, directory, filepath, mtl
          , parsec, pretty, process, QuickCheck, stdenv, tagged, tar, tasty
          , tasty-golden, tasty-hunit, tasty-quickcheck, time, transformers
          , unix
          }:
          mkDerivation {
            pname = "Cabal";
            version = "2.1.0.0";
            src = ./cabal/Cabal;
            libraryHaskellDepends = [
              array base binary bytestring containers deepseq directory filepath
              mtl parsec pretty process time transformers unix
            ];
            testHaskellDepends = [
              array base base-compat base-orphans bytestring containers Diff
              directory filepath pretty QuickCheck tagged tar tasty tasty-golden
              tasty-hunit tasty-quickcheck
            ];
            doCheck = false;
            homepage = "http://www.haskell.org/cabal/";
            description = "A framework for packaging Haskell software";
            license = stdenv.lib.licenses.bsd3;
          }
        )
        {};
      cabal-install = self.callPackage
        (
          { mkDerivation, array, async, base, base16-bytestring, binary
          , bytestring, Cabal, containers, cryptohash-sha256, deepseq
          , directory, echo, edit-distance, filepath, hackage-security
          , hashable, HTTP, mtl, network, network-uri, pretty, pretty-show
          , process, QuickCheck, random, resolv, stdenv, stm, tagged, tar, tasty
          , tasty-hunit, tasty-quickcheck, time, unix, zlib
          }:
          mkDerivation {
            pname = "cabal-install";
            version = "2.1.0.0";
            src = ./cabal/cabal-install;
            isLibrary = false;
            isExecutable = true;
            setupHaskellDepends = [ base Cabal filepath process ];
            libraryHaskellDepends = [
              array async base base16-bytestring binary bytestring Cabal
              containers cryptohash-sha256 deepseq directory echo edit-distance
              filepath hackage-security hashable HTTP mtl network network-uri
              pretty process random resolv stm tar time unix zlib
            ];
            executableHaskellDepends = [
              array async base base16-bytestring binary bytestring Cabal
              containers cryptohash-sha256 deepseq directory echo edit-distance
              filepath hackage-security hashable HTTP mtl network network-uri
              pretty process random resolv stm tar time unix zlib
            ];
            testHaskellDepends = [
              array async base bytestring Cabal containers deepseq directory
              edit-distance filepath hashable mtl network network-uri pretty-show
              QuickCheck random tagged tar tasty tasty-hunit tasty-quickcheck
              time zlib
            ];
            doCheck = false;
            postInstall = ''
              mkdir $out/etc
              mv bash-completion $out/etc/bash_completion.d
            '';
            homepage = "http://www.haskell.org/cabal/";
            description = "The command-line interface for Cabal and Hackage";
            license = stdenv.lib.licenses.bsd3;
          }
        )
        {};
    };
  };
in
{
  environment.systemPackages = [
    haskellPackages.cabal-install
  ];
}
