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
      uiucthesis2014.pkgs = [
        (uiucthesis2014 // { pname = "uiucthesis2014"; tlType = "run"; })
      ];
    })
    biber

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
    quilt
    repos
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

    chromium
    ( # Firefox
      let
        lock =
          builtins.fromJSON (builtins.readFile ./firefox/nixpkgs-channels.json);
        bootstrap = fetchgit {
          inherit (lock) url rev sha256 fetchSubmodules;
        };
        nixpkgs = import bootstrap {};
        inherit (nixpkgs) firefox;
      in
        firefox
    )
    gimp
    inkscape
    # libreoffice-fresh
    lyx
    skypeforlinux
    spotify
    vlc
  ];

  programs.adb.enable = true;
}
