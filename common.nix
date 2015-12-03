{ config, pkgs, ... }:

{
  imports = [
    ./emacs.nix
    ./gpg-agent.nix
    ./features/dvorak-swapcaps
    ./features/hplip
    ./features/kde5.nix
    ./config/fonts.nix
    ./programs
    ./users.nix
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
