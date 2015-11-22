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
  mathematica_pkgs = import ./pkgs/mathematica { inherit config; };

in

config // {
  packageOverrides = super: let self = super.pkgs; in {

    kf5_stable = self.kf5_latest;
    plasma5_stable = self.plasma5_latest;
    kdeApps_stable = self.kdeApps_latest;

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

      mathematica = mathematica_pkgs.callPackage ./mathematica.nix {
        patchelf = mathematica_pkgs.callPackage ./patchelf.nix {};
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

    Cabal_HEAD = with self.haskell.lib; with self.ttuegel;
      let drv = self.haskellPackages.callPackage ./generated/Cabal.nix {};
      in overrideCabal drv (drv: drv // {
        src = builtins.filterSource
          (path: type: omitGit path type && omitBuildDir path type)
          drv.src;
        preCheck = "unset GHC_PACKAGE_PATH; export HOME=$NIX_BUILD_TOP";
      });

    Cabal_DEV = self.Cabal_HEAD.env;

    cabal-install_HEAD = with self.haskell.lib; with self.ttuegel;
      let drv = self.haskellPackages.callPackage ./generated/cabal-install.nix {
            Cabal = dontCheck self.Cabal_HEAD;
          };
      in overrideCabal drv (drv: drv // {
        src = builtins.filterSource
          (path: type: omitGit path type && omitBuildDir path type)
          drv.src;
        preCheck = "unset GHC_PACKAGE_PATH; export HOME=$NIX_BUILD_TOP";
      });

    cabal-install_DEV = self.cabal-install_HEAD.env;

    redeclipse = self.callPackage ./redeclipse.nix {};

  };
}
