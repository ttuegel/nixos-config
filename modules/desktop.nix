{ config, lib, pkgs, ... }:

{
  imports = [
    ./fonts.nix
    ./ssh.nix
  ];

  hardware.enableAllFirmware = true;

  hardware.pulseaudio.enable = lib.mkDefault true;
  # Zoom is currently broken with Pipewire
  services.pipewire.enable = false;

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
    enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };

  services.xserver.libinput.enable = true;

}
