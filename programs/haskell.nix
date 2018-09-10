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
    hie-nix.hies
    hlint
    hpack
    stack
    stylish-haskell
  ];
}
