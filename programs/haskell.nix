{ lib, pkgs, ... }:

with pkgs; with haskellPackages;

let
  ghcide-nix =
    import (builtins.fetchTarball "https://github.com/hercules-ci/ghcide-nix/tarball/master") {};
  inherit (ghcide-nix) ghcide-ghc865;
in

{
  environment.systemPackages = with pkgs; with haskellPackages; [
    ghc
    cabal2nix
    cabal-install
    ghcid
    ghcide-ghc865
    hlint
    hpack
    pandoc
    (haskell.lib.doJailbreak profiteur)
    profiterole
    shake
    stack
    stylish-haskell
    tasty-discover
    viewprof
  ];
}
