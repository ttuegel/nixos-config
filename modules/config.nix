{ config, pkgs, ... }:

{
  imports = [
    ./nixpkgs.nix
    ./terminfo.nix
    ./udev.nix
  ];

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  services.avahi.enable = true;
  services.avahi.nssmdns = true;

  services.ntp.enable = false;
  services.chrony.enable = true;
}
