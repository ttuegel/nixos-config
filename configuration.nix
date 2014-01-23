{ config, pkgs, ... }:

{
  imports =
    [
      ./host.nix    # Point this symlink to host-specific configuration.
      ./fonts.nix
    ];

  environment.systemPackages = with pkgs; [
    clementine
    cryptsetup
    darcs
    ddrescue
    dropbox
    emacs
    ffmpeg_2
    firefoxWrapper
    git
    gitAndTools.gitAnnex
    htop
    kde4.ark
    kde4.k3b
    kde4.kde_gtk_config
    kde4.kmix
    kde4.ksshaskpass
    kde4.kwallet
    kde4.okular
    kde4.qtcurve
    kde4.quasselClient
    keepassx
    keychain
    mkvtoolnix
    mosh
    mplayer
    mpv
    mr
    ogmtools
    oxygen_gtk
    stow
    tmux
    vim_configurable
    vlc
    vobsub2srt
    wget
    zsh
  ];
  # ] ++ kde4.telepathy.full;

  hardware.pulseaudio.enable = true;

  i18n = {
    consoleKeyMap = "dvorak";
    defaultLocale = "en_US.UTF-8";
  };

  networking.networkmanager.enable = true;

  programs.zsh.enable = true;

  services.avahi.enable = true;
  services.avahi.nssmdns = true;

  #services.dbus.packages = pkgs.kde4.telepathy.full;

  services.ntp.enable = true;

  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;
  services.openssh.permitRootLogin = "no";

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip ];

  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "dvorak";

  services.xserver.displayManager.kdm.enable = true;
  services.xserver.desktopManager.kde4.enable = true;

  time.timeZone = "America/Chicago";

  nix.binaryCaches = [ "http://cache.nixos.org/" "http://hydra.nixos.org/" ];

  nixpkgs.config = {
    cabal.libraryProfiling = true;
    ffmpeg.faac = true;
    ffmpeg.fdk = true;
    pulseaudio = true;

    packageOverrides = pkgs: with pkgs; {
      emacs = emacs.override { withToolkitScrollbars = false; };
      kde4 = recurseIntoAttrs kde411;
    };
  };
}
