self: with self;

{
  feast = callPackage ./feast {
    openblas = openblasCompat;
  };

  otfcc = callPackage ./otfcc {};
}
