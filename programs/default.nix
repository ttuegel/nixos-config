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
    kde5.spectacle
    kde5.okular

    aspell
    aspellDicts.en
    cloc
    darcs
    git
    gitAndTools.git-annex
    gnupg
    gnuplot_qt
    haskellPackages.cabal2nix
    haskellPackages.cabal-install
    haskellPackages.ghcid
    htop
    ledger
    linuxPackages.cpupower
    llvm
    manpages
    mr
    nox
    pass
    quilt
    rubber
    silver-searcher
    sox
    (texlive.combine {
      inherit (texlive) scheme-small collection-publishers collection-science;
      inherit (texlive) latexmk;
    })
    tmux
    vcsh
    wget
    youtube-dl

    clementine
    dropbox
    firefoxWrapper
    gimp
    inkscape
    ipe
    lyx
    pidgin
    quasselClient_kf5
    spotify
    vlc
    zotero
  ];
}
