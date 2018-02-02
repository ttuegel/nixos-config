self: super: with self;

{
  feast = callPackage ./feast {
    openblas = openblasCompat;
  };
  uiucthesis2014 = callPackage ./uiucthesis2014.nix {};
}
