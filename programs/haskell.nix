{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; with haskellPackages; [
    haskell.compiler.ghc822
    cabal2nix
    cabal-install
    hindent
    hlint
    hpack
    stack
    stylish-haskell
  ];
}
