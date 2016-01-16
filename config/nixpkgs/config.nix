pkgs:

let

  config = {
    allowBroken = true;
    allowUnfree = true;
    clementine.spotify = true;
    firefox = {
      enableAdobeFlash = true;
      enableGoogleTalkPlugin = true;
      jre = false;
    };
    pulseaudio = true;
  };

in

config // {
  packageOverrides = super: let self = super.pkgs; in
    super.lib.fold (a: b: a // b) {}
    [
      (import ../../overrides/cabal self super)
      (import ../../overrides/gnupg self super)
      (import ../../overrides/gnuplot.nix self super)
      (import ../../overrides/helpers.nix self super)
      ({
        feast = self.callPackage ../../pkgs/feast
          { openblas = self.openblasCompat; };
      })
    ];
}
