{ config, pkgs, ... }:

{
  imports = [
    ./haskell.nix
    ./nix.nix
    ./ssh.nix
  ];

  services.nixosManual.enable = false; # It's always broken anyway.

  programs.command-not-found.enable = false;

  nixpkgs.config.packageOverrides = super: let self = super.pkgs; in {
    # Pin Firefox to allow updating independently from the system.
    # browserpass must come from the same version of Nixpkgs as Firefox.
    inherit (import ./firefox self super) firefox-unwrapped browserpass;
  };

  environment.systemPackages = with pkgs; [
    # Encryption
    cryptsetup
    gnupg pinentry_qt5

    # Languages
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

    firefox
    gimp
    inkscape
    # libreoffice-fresh
    lyx
    skypeforlinux
    spotify
    vlc
  ];

  programs.adb.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;
}
