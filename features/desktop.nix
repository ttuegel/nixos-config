{ config, pkgs, ... }:

{
  imports = [
    ../features/kde5.nix
  ];

  hardware.enableAllFirmware = true;
  hardware.pulseaudio.enable = true;
}
