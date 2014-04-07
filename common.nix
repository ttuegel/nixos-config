{ config, pkgs, ... }:

{
  imports =
    [
      ./fonts.nix
      ./passwords.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_3_12;

  environment.systemPackages = with pkgs; [
    cryptsetup
    kde4.k3b
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
  services.xserver.desktopManager.kde4.enable = true;

  time.timeZone = "America/Chicago";

  users.defaultUserShell = "/var/run/current-system/sw/bin/bash";

  nix.binaryCaches = [
    "http://cache.nixos.org/"
    "http://hydra.nixos.org/"
  ];

  nixpkgs.config = {
    cabal.libraryProfiling = true;
    chromium.enableAdobeFlash = true;
    chromium.enableGoogleTalkPlugin = true;
    chromium.jre = true;
    ffmpeg.faac = true;
    ffmpeg.fdk = true;
    firefox.enableAdobeFlash = true;
    firefox.enableGoogleTalkPlugin = true;
    firefox.jre = true;
    pulseaudio = true;
    virtualbox.enableExtensionPack = true;

    packageOverrides = pkgs: with pkgs; {
      qt48_gtk = pkgs.qt48.override { gtkStyle = true; };
      kde4 = recurseIntoAttrs kde412;

      hsEnv = haskellPackages.ghcWithPackages
        (pkgs: with pkgs; [
          xmonad
          xmonadContrib
        ]);

      hplip = hplip.override { withPlugins = true; };
    };
  };

  environment.variables = {
    LD_LIBRARY_PATH = [ "${pkgs.qt48_gtk}/lib" ];
  };

  users.mutableUsers = false;
  users.extraUsers = {
    ttuegel = {
      uid = 1000;
      description = "Thomas Tuegel";
      home = "/home/ttuegel";
      shell = "/var/run/current-system/sw/bin/zsh";
      group = "users";
      extraGroups = [ "networkmanager" "vboxusers" "wheel" ];
    };
  };
}
