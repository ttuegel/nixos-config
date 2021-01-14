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
    nix-prefetch-scripts
    maxima

    # Utilities
    aspell aspellDicts.en
    briss  # crop PDFs
    cloc
    direnv
    entr  # run arbitrary commands when files change
    fd  # sensible replacement for `find'
    ghostscript
    git vcsh gitAndTools.gitflow git-lfs
    htop
    keyutils  # for `keyctl', for `ecryptfs'
    libburn
    manpages
    cachix niv
    pass
    ripgrep  # sensible replacement for `ag' and `grep'
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
