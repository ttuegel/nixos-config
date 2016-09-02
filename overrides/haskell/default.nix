self: super:

let pkgs = self; in

{
  ttuegel = {

    filterSourceHs = drv: self.haskell.lib.overrideCabal drv (drv: drv // {
      src = with self.ttuegel;
        builtins.filterSource
        (path: type: omitGit path type && omitBuildDir path type)
        drv.src;
      });
  };

  haskellPackages = super.haskellPackages.override {
    overrides = self: super: {
      hindent = self.callPackage ./hindent.nix {
        haskell-src-exts =
          pkgs.haskell.lib.dontCheck self.haskell-src-exts_1_18_2;
      };
    };
  };
}
