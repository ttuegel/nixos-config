{ config, pkgs, ... }:

{
  imports = [
    ./haskell.nix
    ./nix.nix
  ];

  documentation.nixos.enable = false; # It's always broken anyway.

  programs.command-not-found.enable = false;

  environment.systemPackages = with pkgs; [
    # Encryption
    cryptsetup

    # Languages
    clang llvm
    nix-prefetch-scripts
    maxima

    # Utilities
    aspell aspellDicts.en
    briss # crop PDFs
    cloc
    direnv
    fd # sensible replacement for `find'
    ghostscript
    git vcsh gitAndTools.gitflow git-lfs
    hledger
    htop
    keyutils  # for `keyctl', for `ecryptfs'
    ledger
    libburn
    lorri
    manpages
    cachix niv
    pass
    poppler_utils # Tools for manipulating PDF files
    quilt
    # repos
    ripgrep # sensible replacement for `ag' and `grep'
    tmux
    w3m

    # KDE
    audaciousQt5
    ark
    gwenview
    kcolorchooser
    konsole
    okular
    spectacle

    firefox
    gimp
    inkscape
    lyx
    spotify
    vlc
    zoom-us
  ];

  programs.adb.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;

  services.keybase.enable = true;
}
