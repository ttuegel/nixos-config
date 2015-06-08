{ config, pkgs, ... }:

{
  imports = [
    ./emacs.nix
    ./gpg-agent.nix
    ./passwords.nix
  ];

  boot = {
    kernelModules = [ "cpufreq_performance" ];
  };

  environment.systemPackages = with pkgs; [
    cryptsetup
    hplipWithPlugin

    # KDE packages that need to be kept in sync
    kde4.k3b
    kdeApps_stable.ark
    kdeApps_stable.gwenview
    kdeApps_stable.kcolorchooser
    kdeApps_stable.kmix
    kdeApps_stable.ksnapshot
    kdeApps_stable.okular

    aspell
    aspellDicts.en
    bazaar
    cloc
    darcs
    ddrescue
    gdb
    gimp
    git
    gitAndTools.darcsToGit
    gnupg21
    gnuplot_qt
    haskellPackages.cabal2nix
    haskellPackages.cabal-install
    haskellPackages.ghcid
    (haskellPackages.ghcWithPackages (self: with self; [
      formatting
      hmatrix
      io-streams
      lens
      record
      vector
      vector-algorithms
    ]))
    haskellPackages.hledger
    htop
    linuxPackages.cpupower
    llvm
    manpages
    mosh
    mr
    nox
    pass
    pdftk
    silver-searcher
    sox
    tmux
    vcsh
    wget
    youtube-dl

    clementine
    dropbox
    firefoxWrapper
    keepassx2
    inkscape
    lyx
    pidgin
    quasselClient_qt5
    vlc
    zotero
  ];

  environment.variables =
    let root_channels = "/nix/var/nix/profiles/per-user/root/channels";
    in {
      NIX_PATH = pkgs.lib.mkOverride 0 [
        "nixpkgs=/etc/nixos/nixpkgs"
        "nixos=/etc/nixos/nixpkgs/nixos"
        "nixos-config=/etc/nixos/configuration.nix"
      ];
    };

  fonts.fontconfig = {
    hinting = {
      style = "slight";
      autohint = false;
    };
    ultimate = {
      allowBitmaps = false;
      enable = true;
      rendering = pkgs.fontconfig-ultimate.rendering.ultimate-darker;
    };
    includeUserConf = false;
  };

  fonts.fonts = with pkgs; [
    dejavu_fonts
    vistafonts
    corefonts
    wqy_microhei
    lohit-fonts
    source-code-pro
    source-sans-pro
    source-serif-pro
  ];

  hardware.enableAllFirmware = true;
  hardware.pulseaudio.enable = true;

  # HP printer/scanner support
  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.hplipWithPlugin ];
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplipWithPlugin ];

  i18n = {
    consoleKeyMap = (pkgs.callPackage ./dvorak-swapcaps.nix {});
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

  services.psd = {
    enable = true;
    users = [ "ttuegel" ];
    browsers = [ "chromium" "firefox" ];
    resyncTimer = "20m";
  };

  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "dvorak";
  services.xserver.xkbOptions = "ctrl:swapcaps";

  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.kde5.enable = true;

  time.timeZone = "America/Chicago";

  users.defaultUserShell = "/var/run/current-system/sw/bin/bash";

  nix = {
    binaryCaches = [
      "http://cache.nixos.org/"
    ];
    trustedBinaryCaches = [
      "http://192.168.0.124:5000/"
    ];
  };

  nixpkgs.config = {
    allowBroken = true;
    allowUnfree = true;
    clementine.spotify = true;
    firefox = {
      enableAdobeFlash = true;
      enableGoogleTalkPlugin = true;
      jre = false;
    };
    pulseaudio = true;

    packageOverrides = super: let self = super.pkgs; in {
      kdeApps_stable = super.kdeApps_latest;
      plasma5_stable = super.plasma5_latest;
      pinentry_qt = super.pinentry.override { inherit (super) qt4; };
      emacs_custom = self.emacsWithPackages
        (with self.emacsPackages; with self.emacsPackagesNg; [
          auctex
          company
          #company-ghc
          diminish
          evil
          #evil-indent-textobject
          evil-leader
          #evil-surround
          flycheck
          #ghc-mod
          git-auto-commit-mode
          git-timemachine
          haskell-mode
          helm
          magit
          markdown-mode
          monokai-theme
          org-plus-contrib
          #org
          rainbow-delimiters
          undo-tree
          use-package
        ]);
    };
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
}
