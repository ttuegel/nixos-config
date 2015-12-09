{ config, pkgs, ... }:

{
  imports = [
    ./passwords.nix
    ./config/fonts.nix
    ./config/passwords.nix
  ];

  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
  };

  boot.cleanTmpDir = true;

  environment.systemPackages = with pkgs; [
    # KDE packages that need to be kept in sync
    kde4.k3b
    kdeApps_stable.ark
    kdeApps_stable.gwenview
    kdeApps_stable.ksnapshot
    kdeApps_stable.okular
  ];

  hardware.pulseaudio.enable = true;

  i18n = {
    consoleKeyMap = (pkgs.callPackage ./dvorak-swapcaps.nix {});
    defaultLocale = "en_US.UTF-8";
  };

  programs.zsh.enable = true;

  services.ntp.enable = true;

  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;
  services.openssh.permitRootLogin = "no";

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
