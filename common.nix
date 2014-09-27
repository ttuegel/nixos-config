{ config, pkgs, ... }:

{
  imports =
    [
      ./fonts.nix
      ./infinality.nix
      ./new-fontconfig.nix
      ./passwords.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_3_12;

  environment.systemPackages = with pkgs; [
    cryptsetup
    hplipWithPlugin

    # optical burning
    cdrkit
    dvdplusrwtools
    kde4.k3b

    # KDE packages that need to be kept in sync
    kde4.ark
    kde4.gwenview
    kde4.kde_gtk_config
    kde4.kmix
    kde4.ksshaskpass
    kde4.plasma-nm
    kde4.qtcurve

    git

    nix-binary-cache

    aspell
    aspellDicts.en
    autoconf
    bazaar
    cloc
    darcs
    git
    gitAndTools.darcsToGit
    gitAndTools.gitAnnex
    gnuplot
    haskellPackages.cabal2nix
    haskellPackages.cabalInstall
    haskellPackages.ghcMod
    haskellPackages.hledger
    (haskellPackages.hoogleLocal.override {
      packages = with haskellPackages; [
        conduit
        conduitExtra
        haskellPlatform
        hmatrix
        lens
        monoTraversable
        resourcet
        vector
        vectorAlgorithms
      ];
    })
    htop
    llvm
    manpages
    mosh
    mr
    pdftk
    silver-searcher
    stdenv
    stow
    tmux
    wget

    chromiumBeta
    clementine
    dropbox
    emacs
    firefoxWrapper
    evince
    kde4_next.kcolorchooser
    kde4_next.ksnapshot
    kde4_next.quassel
    keepassx2
    keychain
    inkscape
    lyx
    pidgin
    vim_configurable # not cli because depends on X
    vlc
    zotero
  ];

  environment.variables =
    let root_channels = "/nix/var/nix/profiles/per-user/root/channels";
    in {
      NIX_PATH = pkgs.lib.mkOverride 0 [
        ("nixpkgs=" + root_channels + "/unstable")
        ("nixos=" + root_channels + "/unstable/nixos")
        "nixos-config=/etc/nixos/configuration.nix"
      ];
    };

  hardware.pulseaudio.enable = true;

  i18n = {
    consoleKeyMap = "dvorak";
    defaultLocale = "en_US.UTF-8";
  };

  networking.networkmanager.enable = true;

  programs.zsh.enable = true;

  services.avahi.enable = true;
  services.avahi.nssmdns = true;

  services.ntp.enable = true;

  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;
  services.openssh.permitRootLogin = "no";

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplipWithPlugin ];

  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "dvorak";
  services.xserver.xkbOptions = "ctrl:swapcaps";

  services.xserver.displayManager.kdm.enable = true;
  services.xserver.desktopManager.kde4.enable = true;
  #services.xserver.desktopManager.gnome3.enable = true;

  time.timeZone = "America/Chicago";

  users.defaultUserShell = "/var/run/current-system/sw/bin/bash";

  nix.binaryCaches = [
    "http://cache.nixos.org/"
    "http://hydra.nixos.org/"
  ];

  nixpkgs.config = {
    allowUnfree = true;
    cabal.libraryProfiling = true;
    chromium = {
      enablePepperFlash = true;
      enablePepperPDF = false;
    };
    firefox = {
      enableAdobeFlash = true;
      enableGoogleTalkPlugin = true;
      jre = true;
    };
    pulseaudio = true;
    virtualbox.enableExtensionPack = true;
  };

  users.mutableUsers = false;
  users.extraUsers = {
    ttuegel = {
      uid = 1000;
      description = "Thomas Tuegel";
      home = "/home/ttuegel";
      shell = "/var/run/current-system/sw/bin/zsh";
      group = "users";
      extraGroups = [ "lp" "networkmanager" "vboxusers" "wheel" ];
    };
  };

  system.replaceRuntimeDependencies = with pkgs;
    let bash42-048 = fetchurl {
          url = "mirror://gnu/bash/bash-4.2-patches/bash42-048";
          sha256 = "091xk1ms7ycnczsl3fx461gjhj69j6ycnfijlymwj6mj60ims6km";
        };
        bash42-049 = fetchurl {
          url = "mirror://gnu/bash/bash-4.2-patches/bash42-049";
          sha256 = "1d2ympd8icz3q3kbsf2d8inzqpv42q1yg12kynf316msiwxdca3z";
        };
    in [
      {
        original = bash;
        replacement = pkgs.lib.overrideDerivation bash (old: {
          patches = old.patches ++ [ bash42-048 bash42-049 ];
        });
      }
      {
        original = bashInteractive;
        replacement = pkgs.lib.overrideDerivation bashInteractive (old: {
          patches = old.patches ++ [ bash42-048 bash42-049 ];
        });
      }
    ];

}
