{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware.nix
      ../../config
      ../../features/desktop.nix
      ../../features/dvorak-swapcaps
      ../../features/fstrim.nix
      ../../features/gnupg.nix
      ../../features/hplip.nix
      ../../features/zerotier.nix
      ../../programs
      ../../programs/direnv.nix
      ../../programs/emacs.nix
      ../../programs/fish.nix
      ../../users.nix
    ];

  boot.loader.systemd-boot.enable = true;

  boot.tmpOnTmpfs = false;

  networking.hostName = "pollux";

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

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s25.useDHCP = true;
  networking.interfaces.wlp4s0.useDHCP = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}
