self: super:

{
  ttuegel = {

    filterSourceHs = drv: self.haskell.lib.overrideCabal drv (drv: drv // {
      src = with self.ttuegel;
        builtins.filterSource
        (path: type: omitGit path type && omitBuildDir path type)
        drv.src;
      });

    Cabal = with self.haskell.lib; with self.ttuegel;
      let drv = with self.haskellPackages; callPackage ./Cabal.nix {};
      in overrideCabal (self.ttuegel.filterSourceHs drv) (drv: drv // {
        preCheck = "unset GHC_PACKAGE_PATH; export HOME=$NIX_BUILD_TOP";
      });

    cabal-install = with self.haskell.lib; with self.ttuegel;
      let haskellPackages = self.haskellPackages.override {
            overrides = self_: super_: {
              ed25519 = dontCheck super_.ed25519;
              Cabal = dontCheck self.ttuegel.Cabal;
              hackage-security =
                dontHaddock
                (dontCheck
                (self.ttuegel.filterSourceHs (self_.callPackage ./hackage-security.nix { })));
            };
          };
          drv = haskellPackages.callPackage ./cabal-install.nix {};
      in doJailbreak (dontCheck (self.ttuegel.filterSourceHs (overrideCabal drv (drv: drv // {
        preCheck = "unset GHC_PACKAGE_PATH; export HOME=$NIX_BUILD_TOP";
      }))));

    vector = with self.haskell.lib; with self.haskellPackages;
      dontCheck
      self.ttuegel.filterSourceHs (callPackage ./vector.nix {});
  };
}
