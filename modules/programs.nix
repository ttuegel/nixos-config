{ config, pkgs, ... }:

{
  imports = [
    ./nix.nix
  ];

  documentation.nixos.enable = false; # It's always broken anyway.

  programs.command-not-found.enable = false;

  environment.systemPackages = with pkgs; [
    # Encryption
    cryptsetup

    # Languages
    clang llvm
    nurl

    cabal-install
    (haskell.packages.ghc96.ghcWithPackages (hs: [hs.zlib]))
    haskell-language-server

    # Utilities
    aspell aspellDicts.en
    cloc
    entr watchexec  # run arbitrary commands when files change
    fd  # sensible replacement for `find'
    git git-lfs vcsh
    htop
    keyutils  # for `keyctl', for `ecryptfs'
    libburn
    man-pages
    cachix niv
    pass _1password
    ripgrep  # sensible replacement for `ag' and `grep'
    tmux
    stoken  # software token manager
    jq

    # KDE
    ark
    gwenview
    kcolorchooser
    konsole
    okular
    spectacle

    emacs-unstable
    firefox
    gimp
    google-chrome
    inkscape
    lyx
    vlc
    zoom-us
  ];

  programs.adb.enable = true;
  programs.ssh.startAgent = true;
}
