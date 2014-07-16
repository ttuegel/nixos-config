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
    # okular is garbage
    # kde4.okular
    kde4.plasma-nm
    kde4.qtcurve
    kde4.quasselClient

    hsEnv

    git

    nix-binary-cache

    rxvt_unicode.terminfo
  ];

  environment.variables = {
    NIX_PATH = pkgs.lib.mkOverride 0 [
      "nixpkgs=/home/ttuegel/.nix-defexpr/nixpkgs"
      "nixos=/home/ttuegel/.nix-defexpr/nixpkgs/nixos"
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
  services.xserver.desktopManager.gnome3.enable = true;

  time.timeZone = "America/Chicago";

  users.defaultUserShell = "/var/run/current-system/sw/bin/bash";

  nix.binaryCaches = [
    "http://cache.nixos.org/"
    "http://hydra.nixos.org/"
  ];

  nixpkgs.config = {
    allowUnfree = true;
    cabal.libraryProfiling = true;
    chromium.enableAdobeFlash = true;
    chromium.enableGoogleTalkPlugin = true;
    chromium.jre = true;
    firefox.enableAdobeFlash = true;
    firefox.enableGoogleTalkPlugin = true;
    firefox.jre = true;
    pulseaudio = true;
    virtualbox.enableExtensionPack = true;

    packageOverrides = pkgs: with pkgs; {
      hsEnv = haskellPackages.ghcWithPackages
        (pkgs: with pkgs; [
          xmonad
          xmonadContrib
        ]);

#      hplip = hplip.override { withPlugins = true; };
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

  networking.extraHosts = ''
    54.217.220.47 nixos.org www.nixos.org tarball.nixos.org releases.nixos.org
    131.180.119.77 hydra.nixos.org
  '';

}
