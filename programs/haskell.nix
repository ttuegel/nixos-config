{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; with haskellPackages; [
    haskell.compiler.ghc822
    cabal2nix cabal-install hpack stack stylish-haskell
  ];
}
