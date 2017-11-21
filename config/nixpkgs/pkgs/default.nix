self: super: with self;

{
  feast = callPackage ./feast {
    openblas = openblasCompat;
  };

  alacritty = callPackage ./alacritty.nix {
    inherit (latest.rustChannels.stable) rust cargo;
  };
}
