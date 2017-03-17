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

    notmuch = super.notmuch.overrideAttrs (attrs: {
      patches =
        (attrs.patches or [])
        ++ [
          (self.fetchurl {
            url = "https://github.com/ttuegel/notmuch/commit/3fbc76ab83052113410a7d706099a754855fdaa9.patch";
            sha256 = "0mmi2pfjwlw1wf2jmjwnss3awl0gxn3nail0405dp45gm84xd6sm";
          })
        ];
    });

  };
}
