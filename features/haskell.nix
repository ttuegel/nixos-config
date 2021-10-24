{ lib, pkgs, ... }:

let
  sources = import ../nix/sources.nix;
in

with pkgs; with haskellPackages;

{
  environment.systemPackages = [
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
