{ lib, pkgs, ... }:

let
  sources = import ../nix/sources.nix;
  hls_8_10_4 = import sources."nix-haskell-hls" { ghcVersion = "ghc8104"; };
in

with pkgs; with haskellPackages;

{
  environment.systemPackages = [
    haskell.compiler.ghc8104
    hls_8_10_4.hls-wrapper
    cabal-install
    ghcid
    hlint
    hpack
    (haskell.lib.doJailbreak profiteur)
    profiterole
    shake
    stack
  ];
}
