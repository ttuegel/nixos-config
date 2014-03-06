{ config, pkgs, ... }:

{
  imports =
    [
      ./fonts.nix
      ./passwords.nix
    ];

  environment.systemPackages = with pkgs; [
    cryptsetup
    ffmpeg_2
    firefoxWrapper
    git
    gitAndTools.gitAnnex
    hsEnv
    htop
    #kde4.ark
    #kde4.k3b
    #kde4.kde_gtk_config
    #kde4.kmix
    #kde4.ksshaskpass
    #kde4.kwallet
    #kde4.networkmanagement
    #kde4.okular
    #kde4.qtcurve
    mosh
    networkmanagerapplet
    wget
  ];

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
  services.printing.drivers = [ pkgs.hplip ];

  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "dvorak";
  services.xserver.xkbOptions = "ctrl:swapcaps";

  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  time.timeZone = "America/Chicago";

  users.defaultUserShell = "/var/run/current-system/sw/bin/bash";

  nix.binaryCaches = [
    "http://cache.nixos.org/"
    "http://hydra.nixos.org/"
  ];

  nixpkgs.config = {
    cabal.libraryProfiling = true;
    ffmpeg.faac = true;
    ffmpeg.fdk = true;
    pulseaudio = true;

    packageOverrides = pkgs: with pkgs; {
      qt48 = pkgs.qt48.override { gtkStyle = true; };
      kde4 = recurseIntoAttrs kde412;

      hsEnv = haskellPackages.ghcWithPackages
        (pkgs: with pkgs; [
          xmonad
          xmonadContrib
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
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };
}
