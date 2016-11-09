{ config, pkgs, ... }:

{
  imports = [
    ./nix.nix
    ./ssh.nix
    ./zsh.nix
  ];

  environment.systemPackages = with pkgs; [
    cryptsetup

    aspell aspellDicts.en
    cloc
    darcs
    ghostscript
    git
    gnupg21 pinentry_qt5
    haskellPackages.cabal2nix
    haskellPackages.cabal-install
    haskellPackages.ghc
    haskellPackages.ghcid
    haskellPackages.stack
    htop
    keybase-go
    ledger
    llvm
    manpages
    mr vcsh
    nix-prefetch-scripts nix-repl nox
    pandoc
    pass
    quilt
    rsync
    silver-searcher
    (texlive.combine {
      inherit (texlive)
        scheme-full collection-publishers collection-science;
    })
    tmux
    wget
    youtube-dl

    clementine
    firefox-bin  # I don't have time to build Firefox
    gimp
    inkscape
    ipe
    kde5.ark
    kde5.gwenview
    kde5.kcolorchooser
    kde5.spectacle
    kde5.okular
    lyx
    pkgsi686Linux.skype
    quassel
    spotify
    vlc
  ];

  # Needed for GHC 8
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
