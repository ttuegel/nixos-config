{ config, pkgs, ... }:

{
  imports = [
    ./config/nixpkgs
    ./features/dvorak-swapcaps
    ./programs/nix.nix
    ./programs/ssh.nix
  ];

  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
  };

  boot.cleanTmpDir = true;

  boot.plymouth = {
    enable = false;
    themePackages = [ pkgs.plasma5.breeze-plymouth ];
    theme = "breeze";
  };

  environment.systemPackages = with pkgs; [
    # KDE packages that need to be kept in sync
    k3b
    ark
    gwenview
    okular
    spectacle
  ];

  hardware.pulseaudio.enable = true;

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  programs.zsh.enable = true;

  services.ntp.enable = true;

  services.xserver.enable = true;

  services.xserver.desktopManager.kde5.enable = true;

  services.xserver.displayManager.sddm.enable = true;

  time.timeZone = "America/Chicago";

  users.defaultUserShell = "/var/run/current-system/sw/bin/bash";

  users.mutableUsers = false;
  users.extraUsers = {
    ttuegel = {
      uid = 1000;
      description = "Thomas Tuegel";
      home = "/home/ttuegel";
      createHome = true;
      shell = "/var/run/current-system/sw/bin/zsh";
      group = "users";
      extraGroups = [ "wheel" ];
      password = "";
    };
  };
}
