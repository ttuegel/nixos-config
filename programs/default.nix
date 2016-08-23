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
    kde5.spectacle
    kde5.okular
    quasselClient

    aspell aspellDicts.en
    cloc
    darcs
    ghostscript
    git
    gitAndTools.gitAnnex
    gnupg21 pinentry_qt5
    haskellPackages.cabal2nix
    haskellPackages.cabal-install
    haskellPackages.ghc
    haskellPackages.ghcid
    haskellPackages.stack
    htop
    ledger
    linuxPackages.cpupower
    llvm
    manpages manpages.docdev
    mr vcsh
    nix-prefetch-scripts nix-repl nox
    pass
    quilt
    rsync
    silver-searcher
    (texlive.combine {
      inherit (texlive) scheme-small collection-publishers collection-science;
    })
    tmux
    wget
    youtube-dl

    clementine
    firefox-bin
    gimp
    inkscape
    ipe
    lyx
    pkgsi686Linux.skype
    spotify
    vlc
  ];
}
