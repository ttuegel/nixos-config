self: super:

{
  ttuegel = (super.ttuegel or {}) // {

    Cabal = with self.haskell.lib; with self.ttuegel;
      let drv = self.haskellPackages.callPackage ./Cabal.nix {};
      in overrideCabal drv (drv: drv // {
        src = with self.ttuegel; builtins.filterSource
          (path: type: omitGit path type && omitBuildDir path type)
          drv.src;
        preCheck = "unset GHC_PACKAGE_PATH; export HOME=$NIX_BUILD_TOP";
      });

    cabal-install = with self.haskell.lib; with self.ttuegel;
      let drv = self.haskellPackages.callPackage ./cabal-install.nix {
            Cabal = dontCheck self.ttuegel.Cabal;
          };
      in overrideCabal drv (drv: drv // {
        src = with self.ttuegel; builtins.filterSource
          (path: type: omitGit path type && omitBuildDir path type)
          drv.src;
        preCheck = "unset GHC_PACKAGE_PATH; export HOME=$NIX_BUILD_TOP";
      });
  };
}
