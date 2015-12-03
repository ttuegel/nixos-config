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
    ./programs/ssh.nix
    ./programs/zsh.nix
    ./users.nix
  ];

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
    cloc
    darcs
    git
    gitAndTools.git-annex
    gnupg
    gnuplot_qt
    haskellPackages.cabal2nix
    haskellPackages.cabal-install
    haskellPackages.ghcid
    htop
    ledger
    linuxPackages.cpupower
    llvm
    manpages
    mr
    nox
    pass
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
    gimp
    inkscape
    ipe
    lyx
    pidgin
    quasselClient_kf5
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

  services.psd = {
    enable = true;
    users = [ "ttuegel" ];
    browsers = [ "chromium" "firefox" ];
    resyncTimer = "20m";
  };

  time.timeZone = "America/Chicago";

  virtualisation.lxc.enable = true;
}
