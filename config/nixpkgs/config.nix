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
            sha256 = "0yvzx23f41ya0jfxdn0v3h0fqh5xhfpf5i6xf5hgayvyd95kzsik";
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
