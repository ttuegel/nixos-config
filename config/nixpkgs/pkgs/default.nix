self: super: with self;

{
  feast = callPackage ./feast {
    openblas = openblasCompat;
  };
}
