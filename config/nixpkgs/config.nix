pkgs:

let

  config = {
    allowBroken = true;
    allowUnfree = true;
    clementine.spotify = true;
    pulseaudio = true;
  };

in

config // {
  packageOverrides = super: let self = super.pkgs; in {

    gnupg = self.gnupg21;

    feast = self.callPackage ./pkgs/feast {
      openblas = self.openblasCompat;
    };

    # Enable OpenGL 4 support
    mesa_drivers = self.mesaDarwinOr (
      let mo = self.mesa_noglu.override {
        grsecEnabled = config.nixpkgs.config.grsecurity or false;
        enableTextureFloats = true;
      };
      in mo.drivers
    );

  };
}
