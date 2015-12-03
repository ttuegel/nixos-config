{ config, pkgs, ... }:

{
  imports = [
    ./emacs.nix
    ./gpg-agent.nix
    ./features/dvorak-swapcaps
    ./features/hplip
    ./features/kde5.nix
    ./fonts.nix
    ./programs/nix.nix
    ./programs/zsh.nix
    ./users.nix
  ];

  boot = {
    kernelModules = [ "cpufreq_performance" ];
  };

  environment.systemPackages = with pkgs; [
    cryptsetup

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
    gitAndTools.git-annex
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

  hardware.enableAllFirmware = true;
  hardware.pulseaudio.enable = true;

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

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

  time.timeZone = "America/Chicago";

  virtualisation.lxc.enable = true;
}
