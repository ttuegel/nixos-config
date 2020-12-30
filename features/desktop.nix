{ config, pkgs, ... }:

{
  imports = [
    ../config/fonts.nix
    ../features/kde5.nix
  ];

  hardware.enableAllFirmware = true;

  hardware.pulseaudio.enable = true;

  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ table table-others ];
  };

  services.colord.enable = true;

  services.earlyoom = {
    enable = true;
    freeMemThreshold = 5;
  };

  services.flatpak.enable = true;

  services.samba.enable = true;

  services.xserver = {
    libinput.enable = true;
  };

}
