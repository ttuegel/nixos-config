{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    desktopManager.kodi.enable = true;
  };
}
