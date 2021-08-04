{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./hardware.nix
      ../../config
      ../../features/desktop.nix
      ../../features/dvorak-swapcaps
      ../../features/gnupg.nix
#      ../../features/haskell.nix
      ../../features/hplip.nix
      ../../features/zerotier.nix
      ../../programs
      ../../programs/emacs.nix
      ../../programs/fish.nix
      ../../programs/vscode.nix
    ];

  boot.supportedFilesystems = [ "zfs" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "hermes";
  networking.hostId = "d9b1725a";

  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    allowPing = true;
  };

  time.timeZone = "America/Chicago";

  nix.maxJobs = 4;
  nix.buildCores = 2;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.wlp0s20f3.useDHCP = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}

