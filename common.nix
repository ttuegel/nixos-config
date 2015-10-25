{ config, pkgs, ... }:

{
  imports = [
    ./emacs.nix
    ./gpg-agent.nix
    ./passwords.nix
  ];

  boot = {
    kernelModules = [ "cpufreq_performance" ];
    kernelPackages = pkgs.linuxPackages_4_2;
  };

  environment.systemPackages = with pkgs; [
    cryptsetup
    hplipWithPlugin

    # KDE packages that need to be kept in sync
    kde4.k3b
    kdeApps_stable.ark
    kdeApps_stable.gwenview
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
    gnupg
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
    htop
    julia
    ledger
    linuxPackages.cpupower
    llvm
    manpages
    mosh
    mr
    nox
    pass
    #pdftk
    silver-searcher
    sox
    (texlive.combine {
      inherit (texlive) scheme-basic collection-publishers collection-science;
    })
    tmux
    vcsh
    wget
    youtube-dl

    clementine
    dropbox
    firefoxWrapper
    keepassx2
    inkscape
    ipe
    lyx
    ttuegel.mathematica
    pidgin
    quasselClient_kf5
    qtpass
    spotify
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
    defaultFonts.monospace = [ "Source Code Pro" "DejaVu Sans Mono" ];
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

  fonts.fonts = with pkgs; with lib; [
    dejavu_fonts
    vistafonts
    corefonts
    wqy_microhei
    source-code-pro
    source-sans-pro
    source-serif-pro
  ] ++ filter isDerivation (attrValues lohit-fonts);

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

  virtualisation.lxc.enable = true;

  nix = {
    binaryCaches = [
      "http://cache.nixos.org/"
      "http://hydra.nixos.org/"
    ];
    trustedBinaryCaches = [
      "http://192.168.0.3:5000/"
    ];
    binaryCachePublicKeys = [
      "tuegel.mooo.com-1:hZ9VCbn2eRfZl3VVYxkFakWH2SSA18vDv87xxT7BKus="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
    ];
  };

  nixpkgs.config = import ./config.nix pkgs;

  users.mutableUsers = false;
  users.extraUsers = {
    ttuegel = {
      uid = 1000;
      description = "Thomas Tuegel";
      home = "/home/ttuegel";
      createHome = true;
      shell = "/var/run/current-system/sw/bin/zsh";
      group = "users";
      extraGroups = [ "lp" "networkmanager" "vboxusers" "wheel" ];
    };
  };
}
