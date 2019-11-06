{ config, pkgs, ... }:

{
  imports = [
    ./haskell.nix
    ./nix.nix
    ./ssh.nix
    ./texlive.nix
  ];

  documentation.nixos.enable = false; # It's always broken anyway.

  programs.command-not-found.enable = false;

  nixpkgs.config.packageOverrides = super: let self = super.pkgs; in {
    # Pin Firefox to allow updating independently from the system.
    # browserpass must come from the same version of Nixpkgs as Firefox.
    # inherit (import ./firefox self super) firefox-unwrapped browserpass;
  };

  environment.systemPackages = with pkgs; [
    # Encryption
    cryptsetup
    gnupg pinentry-qt

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
    git vcsh gitAndTools.gitflow
    hledger
    htop
    isync msmtp notmuch
    keyutils  # for `keyctl', for `ecryptfs'
    ledger
    libburn
    lorri
    manpages
    cachix niv
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
    konsole
    okular
    spectacle

    chromium
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
