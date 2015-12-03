{ config, pkgs, ... }:

{
  imports = [
    ../features/kde5.nix
  ];

  hardware.enableAllFirmware = true;
  hardware.pulseaudio.enable = true;

  services.psd = {
    enable = true;
    users = [ "ttuegel" ];
    browsers = [ "chromium" "firefox" ];
    resyncTimer = "20m";
  };
}
