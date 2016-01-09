super: self:

let pkgs = self; in

{
  ttuegel = (super.ttuegel or {}) // {

    haskell =
      {
        enableProfiling = drv: drv.overrideScope (self: super: {
          mkDerivation = drv: super.mkDerivation (drv // {
            enableLibraryProfiling = true;
          });
          inherit (pkgs) stdenv;
        });

        enableOptimization = drv: drv.overrideScope (self: super: {
          mkDerivation = drv: super.mkDerivation (drv // {
              configureFlags = (drv.configureFlags or []) ++ ["-O"];
          });
          inherit (pkgs) stdenv;
        });
      };

    omitGit = path: type:
      type != "directory" || baseNameOf path != ".git";

    omitBuildDir = path: type:
      type != "directory" || baseNameOf path != "dist";

  };
}
