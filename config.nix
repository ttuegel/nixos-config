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

  hplip_pkgs = import ./pkgs/hplip { inherit config; };

in

config // {
  packageOverrides = super: let self = super.pkgs; in {

    #kf5_stable = super.kf5_latest;
    #kdeApps_stable = super.kdeApps_latest;
    #plasma5_stable = super.plasma5_latest;
    hplip = hplip_pkgs.pkgs.hplip;
    hplipWithPlugin = hplip_pkgs.pkgs.hplipWithPlugin;
    pinentry_qt = super.pinentry.override { inherit (super) qt4; };

    ttuegel = {

      haskell =
        {
          enableProfiling = drv: drv.overrideScope (self: super: {
            mkDerivation = drv: super.mkDerivation (drv // {
              enableLibraryProfiling = true;
            });
            inherit (pkgs) stdenv;
          });

          enableOptimization = drv: drv.overrideScope (self: super: {
            mkDerivation = drv: super.mkDerivation (drv // {
                configureFlags = (drv.configureFlags or []) ++ ["-O"];
            });
            inherit (pkgs) stdenv;
          });
        };

      omitGit = path: type:
        type != "directory" || baseNameOf path != ".git";

      omitBuildDir = path: type:
        type != "directory" || baseNameOf path != "dist";

      mathematica = self.callPackage ./mathematica.nix {
        patchelf = self.callPackage ./patchelf.nix {};
      };

      transcoding = with self; [
        ddrescue
        ffmpeg_2
        mkvtoolnix
        mplayer
        ogmtools
        vobsub2srt
      ];
    };

    gnuplot = super.gnuplot.override { withQt = true; qt = self.qt4; };

    feast = self.callPackage ./feast { openblas = self.openblasCompat; };

    Cabal_HEAD = with self.haskell-ng.lib; with self.ttuegel;
      let drv = self.haskellngPackages.callPackage ./generated/Cabal.nix {};
      in overrideCabal drv (drv: drv // {
        src = builtins.filterSource
          (path: type: omitGit path type && omitBuildDir path type)
          drv.src;
        preCheck = "unset GHC_PACKAGE_PATH; export HOME=$NIX_BUILD_TOP";
      });

    Cabal_DEV = self.Cabal_HEAD.env;

    cabal-install_HEAD = with self.haskell-ng.lib; with self.ttuegel;
      let drv = self.haskellngPackages.callPackage ./generated/cabal-install.nix {
            Cabal = dontCheck self.Cabal_HEAD;
          };
      in overrideCabal drv (drv: drv // {
        src = builtins.filterSource
          (path: type: omitGit path type && omitBuildDir path type)
          drv.src;
        preCheck = "unset GHC_PACKAGE_PATH; export HOME=$NIX_BUILD_TOP";
      });

    cabal-install_DEV = self.cabal-install_HEAD.env;

    ffmpeg = super.ffmpeg.override {
      fdk-aacExtlib = true;
      nonfreeLicensing = true;
      inherit (self) fdk-aac;
    };

    #gnupg = self.gnupg21;

    redeclipse = self.callPackage ./redeclipse.nix {};

  };
}
