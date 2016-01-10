super: self:

{
  gnupg = self.gnupg21;

  gnupg21 = self.lib.overrideDerivation super.gnupg21 (drv: {
    patches = self.copyPathsToStore (self.lib.readPathsFromFile ./. ./series) ++ drv.patches;
  });
}
