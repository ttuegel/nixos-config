self: with self;

{
  feast = callPackage ./feast {
    openblas = openblasCompat;
  };
}
