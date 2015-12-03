{ config, pkgs, ... }:

{
  imports = [
    ./gpg-agent.nix
    ./features/dvorak-swapcaps
    ./features/hplip
    ./features/kde5.nix
    ./config/fonts.nix
    ./config/users.nix
    ./programs
    ./programs/emacs.nix
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
