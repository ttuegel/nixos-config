{ config, pkgs, ... }:

{
  imports = [
    ./features/dvorak-swapcaps
    ./features/hplip
    ./config/desktop.nix
    ./config/fonts.nix
    ./config/nixpkgs
    ./config/users.nix
    ./programs
    ./programs/emacs.nix
    ./programs/gpg-agent.nix
  ];

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  services.avahi.enable = true;
  services.avahi.nssmdns = true;

  services.ntp.enable = true;
}
