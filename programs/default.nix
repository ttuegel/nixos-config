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
    kde5.quasselClient

    aspell aspellDicts.en
    cloc
    darcs
    git
    gnupg21 pinentry_qt5
    haskellPackages.cabal2nix
    haskellPackages.cabal-install
    haskellPackages.ghc
    haskellPackages.ghcid
    htop
    ledger
    linuxPackages.cpupower
    llvm
    manpages
    mr vcsh
    nix-repl nox
    pass
    quilt
    renv
    silver-searcher
    (texlive.combine {
      inherit (texlive) scheme-small collection-publishers collection-science;
    })
    tmux
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
