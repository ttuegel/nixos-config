{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; with haskellPackages; [
    haskell.compiler.ghc843
    cabal2nix
    cabal-install
    hindent
    hlint
    hpack
    stack
    stylish-haskell
  ];
}
