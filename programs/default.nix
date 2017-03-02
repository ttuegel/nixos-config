{ config, pkgs, ... }:

{
  imports = [
    ./nix.nix
    ./ssh.nix
    ./zsh.nix
  ];

  services.nixosManual.enable = false; # It's always broken anyway.

  environment.systemPackages = with pkgs; [
    cryptsetup

    androidenv.platformTools # adb and fastboot
    aspell aspellDicts.en
    bibutils
    clang llvm
    cloc
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
    isyncUnstable notmuch msmtp
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
    ark
    gwenview
    kcolorchooser
    spectacle
    okular
    lyx
    pkgsi686Linux.skype
    spotify
    vlc
  ];

  # Needed for GHC 8
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
