{ config, pkgs, ... }:

{
  imports = [
    ./nix.nix
    ./ssh.nix
    ./zsh.nix
  ];

  services.nixosManual.enable = false; # It's always broken anyway.

  environment.systemPackages = with pkgs; [
    # Encryption
    cryptsetup
    gnupg21 pinentry_qt5

    # Languages
    chibi
    clang llvm
    fricas
    haskellPackages.cabal2nix
    haskellPackages.cabal-install
    haskellPackages.ghc
    haskellPackages.ghcid
    haskellPackages.hpack
    maxima
    rustNightlyBin.rustc rustNightlyBin.cargo

    # TeX
    (texlive.combine {
      inherit (texlive)
        scheme-full collection-publishers collection-science;
    })

    # Utilities
    androidenv.platformTools # adb and fastboot
    aspell aspellDicts.en
    bibutils
    cloc
    ghostscript
    git pass vcsh
    htop
    keybase-go
    ledger
    libburn
    manpages
    msmtp
    nix-prefetch-scripts nix-repl nox
    pandoc
    pdftk poppler_utils # Tools for manipulating PDF files
    quilt
    ripgrep
    tmux

    # KDE
    audaciousQt5
    ark
    gwenview
    kcolorchooser
    okular
    spectacle

    firefox-bin  # I don't have time to build Firefox
    gimp
    inkscape
    ipe
    lyx
    pkgsi686Linux.skype
    spotify
    vlc
  ];

  # Needed for GHC 8
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
