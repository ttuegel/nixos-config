{ lib, pkgs, ... }:

with pkgs; with haskellPackages;

{
  environment.systemPackages = with pkgs; with haskellPackages; [
    ghc
    cabal2nix
    cabal-install
    hlint
    hpack
    stack
    stylish-haskell
  ];
}
