{ config, pkgs, ... }:

{
  imports = [
    ./nix.nix
    ./ssh.nix
    ./zsh.nix
  ];

  environment.systemPackages = with pkgs; [
    cryptsetup

    # KDE packages that need to be kept in sync
    kde5.ark
    kde5.gwenview
    kde5.kcolorchooser
    #kde5.kruler
    kde5.spectacle
    kde5.okular
    kde5.quasselClient

    aspell
    aspellDicts.en
    ats2
    cloc
    darcs
    git
    #gitAndTools.git-annex
    gitAndTools.hub  # command-line interface to GitHub
    gnupg
    gnuplot_qt
    ( # Install the latest pre-release version of cabal-install.
      let inherit (haskell.lib) dontCheck dontHaddock overrideCabal;
          inherit (ttuegel) filterSourceHs;
          cabalPackages = haskellPackages.override {
            overrides = self: super: {
              Cabal =
                overrideCabal
                (self.callPackage ../overrides/haskell/Cabal-1.24.nix {})
                (drv: drv // { preCheck = "unset GHC_PACKAGE_PATH; export HOME=$NIX_BUILD_TOP"; });
              cabal-install =
                dontCheck
                (overrideCabal
                (self.callPackage ../overrides/haskell/cabal-install-1.24.nix {})
                (drv: drv // { preCheck = "unset GHC_PACKAGE_PATH; export HOME=$NIX_BUILD_TOP"; }));
              ed25519 = dontCheck super.ed25519;
              hackage-security =
                dontHaddock
                (dontCheck
                (self.callPackage ../overrides/haskell/hackage-security-0.5.nix {}));
            };
          };
      in cabalPackages.cabal-install
    )
    haskellPackages.cabal2nix
    haskellPackages.ghcid
    htop
    ledger
    linuxPackages.cpupower
    llvm
    manpages
    mr
    nix-repl
    nox
    pass
    postiats-utilities
    quilt
    renv
    rubber
    silver-searcher
    sox
    (texlive.combine {
      inherit (texlive) scheme-small collection-publishers collection-science;
    })
    tmux
    vcsh
    wget
    youtube-dl

    clementine
    firefoxWrapper
    gimp
    inkscape
    ipe
    lyx
    spotify
    vlc
  ];
}
