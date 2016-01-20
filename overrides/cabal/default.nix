self: super:

{
  ttuegel = {

    Cabal = with self.haskell.lib; with self.ttuegel;
      let drv = self.haskellPackages.callPackage ./Cabal.nix {};
      in overrideCabal drv (drv: drv // {
        src = with self.ttuegel; builtins.filterSource
          (path: type: omitGit path type && omitBuildDir path type)
          drv.src;
        preCheck = "unset GHC_PACKAGE_PATH; export HOME=$NIX_BUILD_TOP";
      });

    cabal-install = with self.haskell.lib; with self.ttuegel;
      let drv = with self.haskellPackages; callPackage ./cabal-install.nix {
            Cabal = dontCheck self.ttuegel.Cabal;
            hackage-security = dontHaddock (dontCheck (callPackage ./hackage-security.nix {
              Cabal = dontCheck self.ttuegel.Cabal;
              ed25519 = dontCheck ed25519;
              tar = tar_0_5_0_1;
            }));
            tar = tar_0_5_0_1;
          };
      in dontCheck (overrideCabal drv (drv: drv // {
        src = with self.ttuegel; builtins.filterSource
          (path: type: omitGit path type && omitBuildDir path type)
          drv.src;
        preCheck = "unset GHC_PACKAGE_PATH; export HOME=$NIX_BUILD_TOP";
      }));
  };
}
