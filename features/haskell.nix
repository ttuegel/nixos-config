{ lib, pkgs, ... }:

let
  sources = import ../nix/sources.nix;
  hls_8_10_1 = import sources."nix-haskell-hls" { ghcVersion = "ghc8101"; };
  hls_8_10_2 = import sources."nix-haskell-hls" { ghcVersion = "ghc8102"; };
in

with pkgs; with haskellPackages;

{
  environment.systemPackages = [
    haskell.compiler.ghc8102
    hls_8_10_2.hls-wrapper
    hls_8_10_2.hls-renamed
    hls_8_10_1.hls-renamed
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
