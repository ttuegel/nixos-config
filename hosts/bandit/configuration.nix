{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/agenix.nix
      ../../modules/config.nix
      ../../modules/desktop.nix
      ../../modules/dvorak-swapcaps
      ../../modules/fish.nix
      ../../modules/hplip.nix
      ../../modules/users.nix
      ../../modules/zerotier.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "bandit";
  networking.hostId = "81b00b03";
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowPing = true;
  };

  nix.settings = {
    max-jobs = 4;
    cores = 2;
  };

  time.timeZone = "America/Chicago";

  i18n.defaultLocale = "en_US.UTF-8";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  services.fstrim.enable = false; # Not necessary with ZFS. See also: services.zfs.trim.interval.

  # TLP power management daemon
  services.power-profiles-daemon.enable = false; # Bad defaults and conflicts with TLP.
  services.tlp.enable = true;

}
