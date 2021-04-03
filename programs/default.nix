{ config, pkgs, ... }:

let
  sources = import ../nix/sources.nix;
  inherit (import sources."direnv-nix-lorelei") direnv-nix-lorelei;
in

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
    cloc
    direnv direnv-nix-lorelei
    entr  # run arbitrary commands when files change
    fd  # sensible replacement for `find'
    git vcsh gitAndTools.gitflow git-lfs
    htop
    keyutils  # for `keyctl', for `ecryptfs'
    libburn
    manpages
    cachix niv
    pass
    ripgrep  # sensible replacement for `ag' and `grep'
    tmux

    # KDE
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
