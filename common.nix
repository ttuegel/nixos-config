{ config, pkgs, ... }:

{
  imports = [ ./passwords.nix ];

  boot = {
    kernelPackages = pkgs.linuxPackages_3_14;
    kernelModules = [ "cpufreq_performance" ];
  };

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
    haskellngPackages.cabal2nix
    haskellngPackages.cabal-install
    haskellngPackages.ghcid
    haskellngPackages.hledger
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

  services.virtualboxHost.enable = true;

  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "dvorak";
  services.xserver.xkbOptions = "ctrl:swapcaps";

  services.xserver.displayManager.kdm.enable = true;
  services.xserver.desktopManager.kde5.enable = true;

  time.timeZone = "America/Chicago";

  users.defaultUserShell = "/var/run/current-system/sw/bin/bash";

  nix = {
    binaryCaches = [
      "http://cache.nixos.org/"
      "http://hydra.nixos.org/"
    ];
    extraOptions = ''
      auto-optimise-store = true
    '';
  };

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
      kdeApps_stable = self.kdeApps_latest;
      kdeApps_latest = super.kdeApps_latest.override { kf5 = self.kf5_latest; };
      kdeApps_14_12 = self.kdeApps_latest;
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
