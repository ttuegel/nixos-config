{ lib, pkgs, ... }:

with pkgs; with haskellPackages;

let
  all-hies =
    import (
      fetchFromGitHub {
        owner = "infinisil";
        repo = "all-hies";
        inherit (lib.importJSON ./all-hies.lock.json) rev sha256;
      }
    ) {};
in

{
  environment.systemPackages = with pkgs; with haskellPackages; [
    ghc
    cabal2nix
    cabal-install
    ghcid
    # (all-hies.selection { selector = p: { inherit (p) ghc865 ghc843; }; })
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
