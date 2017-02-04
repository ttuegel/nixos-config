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
    bibutils
    clang llvm
    cloc
    darcs
    ghostscript
    git
    gnupg21 pinentry_qt5
    haskellPackages.cabal2nix
    haskellPackages.cabal-install
    haskellPackages.ghc
    haskellPackages.ghcid
    htop
    keybase-go
    ledger
    libburn
    manpages
    mr vcsh
    nix-prefetch-scripts nix-repl nox
    offlineimap notmuch alot muchsync
    pandoc
    pass
    quilt
    ripgrep
    rsync
    rustNightlyBin.rustc rustNightlyBin.cargo
    (texlive.combine {
      inherit (texlive)
        scheme-full collection-publishers collection-science;
    })
    tmux
    wget
    youtube-dl

    audaciousQt5
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
