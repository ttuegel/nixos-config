{ lib, pkgs, ... }:

with pkgs; with haskellPackages;

{
  imports = [
    ./hie-nix
  ];

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

  nixpkgs.config.packageOverrides = super: {
    haskellPackages = super.haskellPackages.override (attrs: {
      overrides = self: super_:
        let super = attrs.overrides self super_; in
        super // {
          hindent =
            let
              override = attrs: {
                src = fetchgit {
                  inherit (lib.importJSON ./hindent.json) url rev sha256;
                };
              };
            in
              (callPackage ./hindent.nix {}).overrideAttrs override;
        };
    });
  };
}
