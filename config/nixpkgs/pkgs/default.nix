self: super: with self;

{
  feast = callPackage ./feast {
    openblas = openblasCompat;
  };

  alacritty = callPackage ./alacritty.nix {
    rustPlatform = makeRustPlatform latest.rustChannels.stable;
  };
}
