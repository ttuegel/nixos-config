self: super: with self;

{
  feast = callPackage ./feast {
    openblas = openblasCompat;
  };

  repos = haskellPackages.callPackage ./repos.nix {};

  uiucthesis2014 = callPackage ./uiucthesis2014.nix {};
}
