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
    super.lib.fold (f: super: super // f super) {}
    [
      (import ../../overrides/cabal self)
      (import ../../overrides/gnupg self)
      (import ../../overrides/gnuplot.nix self)
      (import ../../overrides/helpers.nix self)
      (super: {
        feast = self.callPackage ../../pkgs/feast
          { openblas = self.openblasCompat; };
      })
    ];
}
