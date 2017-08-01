{ config, pkgs, ... }:

{
  imports = [
    ./fonts
    ./nixpkgs
    ./udev.nix
    ./users.nix
  ];

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  services.avahi.enable = true;
  services.avahi.nssmdns = true;

  services.ntp.enable = true;
}
