{ config, pkgs, ... }:

{
  imports = [
    ./nix.nix
    ./ssh.nix
    ./haskell.nix
  ];

  services.nixosManual.enable = false; # It's always broken anyway.

  programs.command-not-found.enable = false;

  environment.systemPackages = with pkgs; [
    # Encryption
    cryptsetup
    gnupg pinentry_qt5

    # Languages
    chibi
    clang llvm
    nix-prefetch-scripts nix-repl
    maxima

    # TeX
    (texlive.combine {
      inherit (texlive)
        scheme-full
        collection-mathscience
        collection-publishers
        ;
    })

    # Utilities
    aspell aspellDicts.en
    bibutils
    briss # crop PDFs
    cloc
    direnv
    fd # sensible replacement for `find'
    ghostscript
    git vcsh gitAndTools.gitflow
    htop
    isyncUnstable msmtp notmuch
    keybase-go
    ledger
    libburn
    manpages
    pandoc
    pass
    poppler_utils # Tools for manipulating PDF files
    ripgrep # sensible replacement for `ag' and `grep'
    tmux
    w3m

    # KDE
    audaciousQt5
    ark
    gwenview
    kcolorchooser
    okular
    spectacle

    alacritty
    firefox
    gimp
    inkscape
    libreoffice-fresh
    lyx
    skype
    spotify
    vlc
  ];

  programs.adb.enable = true;
}
