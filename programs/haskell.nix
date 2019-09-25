{ lib, pkgs, ... }:

with pkgs; with haskellPackages;

{
  environment.systemPackages = with pkgs; with haskellPackages; [
    ghc
    cabal2nix
    cabal-install
    ghcid
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
