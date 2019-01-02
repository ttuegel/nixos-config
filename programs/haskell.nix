{ lib, pkgs, ... }:

with pkgs; with haskellPackages;

let
  hie-nix =
    import (
      fetchFromGitHub {
        owner = "domenkozar";
        repo = "hie-nix";
        inherit (lib.importJSON ./hie-nix.lock.json)
          rev sha256;
      }
    ) {};
in

{
  environment.systemPackages = with pkgs; with haskellPackages; [
    ghc
    cabal2nix
    cabal-install
    ghcid
    hie-nix.hies
    hlint
    hpack
    (haskell.lib.doJailbreak pandoc)
    (haskell.lib.doJailbreak profiteur)
    profiterole
    stack
    (haskell.lib.doJailbreak stylish-haskell)
    tasty-discover
    viewprof
  ];
}
