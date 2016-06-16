self: super:

{
  ttuegel = {

    filterSourceHs = drv: self.haskell.lib.overrideCabal drv (drv: drv // {
      src = with self.ttuegel;
        builtins.filterSource
        (path: type: omitGit path type && omitBuildDir path type)
        drv.src;
      });
  };
}
