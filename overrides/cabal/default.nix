super: self:

{
  ttuegel = (super.ttuegel or {}) // {

    Cabal = with self.haskell.lib; with self.ttuegel;
      let drv = self.haskellPackages.callPackage ./Cabal.nix {};
      in overrideCabal drv (drv: drv // {
        src = builtins.filterSource
          (path: type: self.ttuegel.omitGit path type && self.ttuegel.omitBuildDir path type)
          drv.src;
        preCheck = "unset GHC_PACKAGE_PATH; export HOME=$NIX_BUILD_TOP";
      });

    cabal-install = with self.haskell.lib; with self.ttuegel;
      let drv = self.haskellPackages.callPackage ./generated/cabal-install.nix {
            Cabal = dontCheck self.Cabal_HEAD;
          };
      in overrideCabal drv (drv: drv // {
        src = builtins.filterSource
          (path: type: self.ttuegel.omitGit path type && self.ttuegel.omitBuildDir path type)
          drv.src;
        preCheck = "unset GHC_PACKAGE_PATH; export HOME=$NIX_BUILD_TOP";
      });
  };
}
