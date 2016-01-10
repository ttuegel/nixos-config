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
    {}
    // import ../../overrides/cabal super self
    // import ../../overrides/gnupg super self
    // import ../../overrides/gnuplot.nix super self
    // import ../../overrides/helpers.nix super self
    // {

      kde5 = self.kde5_latest;

      feast = self.callPackage ../../pkgs/feast { openblas = self.openblasCompat; };

    };
}
