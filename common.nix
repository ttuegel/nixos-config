{ config, pkgs, ... }:

{
  imports =
    [
      ./passwords.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_3_14;

  # For running numerics and building ATLAS
  boot.kernelModules = [ "cpufreq_performance" ];

  environment.systemPackages = with pkgs; [
    cryptsetup
    hplipWithPlugin

    # KDE packages that need to be kept in sync
    kde4.k3b
    kdeApps_14_12.ark
    kdeApps_14_12.gwenview
    kdeApps_14_12.kcolorchooser
    kdeApps_14_12.kmix
    kdeApps_14_12.ksnapshot
    kdeApps_14_12.okular

    git

    nix-binary-cache

    aspell
    aspellDicts.en
    autoconf
    bazaar
    cloc
    darcs
    ddrescue
    git
    gitAndTools.darcsToGit
    gitAndTools.gitAnnex
    gnuplot_qt
    haskellPackages.cabal2nix
    haskellPackages.cabalInstall
    haskellPackages.ghcid
    haskellPackages.hledger
    htop
    linuxPackages.cpupower
    llvm
    manpages
    mosh
    mr
    nox
    pdftk
    silver-searcher
    stdenv
    tmux
    vcsh
    wget

    clementine
    dropbox
    emacs
    firefoxWrapper
    evince
    keepassx2
    keychain
    inkscape
    lyx
    pidgin
    quassel_qt5
    vim_configurable # not cli because depends on X
    vlc
    zotero
  ];

  environment.variables =
    let root_channels = "/nix/var/nix/profiles/per-user/root/channels";
    in {
      NIX_PATH = pkgs.lib.mkOverride 0 [
        ("nixpkgs=" + root_channels + "/unstable/nixpkgs")
        ("nixos=" + root_channels + "/unstable/nixos")
        "nixos-config=/etc/nixos/configuration.nix"
      ];
      QT_GRAPHICSSYSTEM = "native";
    };

  fonts.fontconfig = {
    hinting = {
      style = "full";
      autohint = false;
    };
    ultimate = {
      allowBitmaps = false;
      enable = true;
      rendering = pkgs.fontconfig-ultimate.rendering.ultimate;
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

  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.hplipWithPlugin ];

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

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplipWithPlugin ];

  services.virtualboxHost.enable = true;

  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "dvorak";
  services.xserver.xkbOptions = "ctrl:swapcaps";

  services.xserver.displayManager.kdm.enable = true;
  #services.xserver.desktopManager.kde4.enable = true;
  #services.xserver.desktopManager.gnome3.enable = true;
  services.xserver.desktopManager.kde5.enable = true;

  time.timeZone = "America/Chicago";

  users.defaultUserShell = "/var/run/current-system/sw/bin/bash";

  nix.binaryCaches = [
    "http://cache.nixos.org/"
    "http://hydra.nixos.org/"
  ];

  nixpkgs.config = {
    allowUnfree = true;
    firefox = {
      enableAdobeFlash = true;
      enableGoogleTalkPlugin = true;
      jre = true;
    };
    pulseaudio = true;
    virtualbox.enableExtensionPack = true;

    packageOverrides = super: let self = super.pkgs; in {
      kf5_stable = self.kf5_latest;
      plasma5_stable = self.plasma5_latest;
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
