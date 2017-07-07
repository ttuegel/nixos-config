pkgs:

let

  config = {
    allowBroken = true;
    allowUnfree = true;
    clementine.spotify = true;
    permittedInsecurePackages = [
      "webkitgtk-2.4.11" # For astroid
    ];
    pulseaudio = true;
  };

in

config // {
  packageOverrides = super: let self = super.pkgs; in {

    gnupg = self.gnupg21;

    feast = self.callPackage ./pkgs/feast {
      openblas = self.openblasCompat;
    };

    # Enable OpenGL 4 support and select drivers
    mesa_drivers = self.mesaDarwinOr (
      let mo = self.mesa_noglu.override {
        grsecEnabled = false;
        enableTextureFloats = true;
        galliumDrivers = [ "radeonsi" ];
        driDrivers = [ "i965" ];
        vulkanDrivers = [];
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
      prePatch = attrs.patchPhase;
      patchPhase = "patchPhase";
    });

    /*
    fontconfig-penultimate = super.fontconfig-penultimate.overrideAttrs (attrs: {
      src = /home/ttuegel/fontconfig-penultimate;
    });
    */

  };
}
