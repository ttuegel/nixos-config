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

    kdeApps_stable = super.kdeApps_latest;
    hplip = hplip_pkgs.pkgs.hplip;
    hplipWithPlugin = hplip_pkgs.pkgs.hplipWithPlugin;
    plasma5_stable = super.plasma5_latest;
    pinentry_qt = super.pinentry.override { inherit (super) qt4; };

    ttuegel = {

      texlive = self.texLiveAggregationFun {
        paths = with self; [
          texLive texLiveExtra texLiveBeamer
        ];
      };

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

    Cabal_HEAD = with self.haskell-ng.lib; with self.ttuegel.haskell;
      let drv = self.haskellngPackages.callPackage ./generated/Cabal.nix {};
      in overrideCabal (dontCheck drv) (drv: drv // {
        src = builtins.filterSource
          (path: type: omitGit path type && omitBuildDir path type)
          drv.src;
      });

    Cabal_DEV = (self.haskell-ng.lib.doCheck self.Cabal_HEAD).env;

    cabal-install_HEAD = with self.haskell-ng.lib; with self.ttuegel.haskell;
      let drv = self.haskellngPackages.callPackage ./generated/cabal-install.nix {
            zlib = self.haskellngPackages.zlib_0_5_4_2;
            Cabal = self.Cabal_HEAD;
          };
      in overrideCabal (dontCheck drv) (drv: drv // {
        src = builtins.filterSource
          (path: type: omitGit path type && omitBuildDir path type)
          drv.src;
        preCheck = "unset GHC_PACKAGE_PATH; export HOME=$NIX_BUILD_TOP";
      });

    cabal-install_DEV = (self.cabal-install_HEAD.override { Cabal = null; }).env;

    ffmpeg = super.ffmpeg.override {
      fdk-aacExtlib = true;
      nonfreeLicensing = true;
      inherit (self) fdk-aac;
    };

    redeclipse = self.callPackage ./redeclipse.nix {};

  };
}
