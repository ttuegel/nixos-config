{ config, pkgs, ... }:

{
  imports = [
    ../features/kde5.nix
  ];

  hardware.enableAllFirmware = true;

  hardware.pulseaudio.enable = true;

  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ table table-others ];
  };

  services.flatpak.enable = true;

  services.colord.enable = true;
  services.samba.enable = true;

  services.xserver = {
    startDbusSession = false;
    libinput.enable = true;
  };

  services.dbus.socketActivated = true;

  programs.ssh.startAgent = false;
}
