{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./hardware.nix
      ../../modules/config.nix
      ../../modules/desktop.nix
      ../../modules/dvorak-swapcaps
      ../../modules/hplip.nix
      ../../modules/zerotier.nix
      ../../modules/programs.nix
      ../../modules/direnv.nix
      ../../modules/emacs.nix
      ../../modules/fish.nix
      ../../mercury/pritunl.nix
      ../../mercury/postgresql.nix
      ../../modules/users.nix
    ];

  boot.kernelParams = [ "zfs.zfs_arc_max=1073741824" ];

  boot.supportedFilesystems = [ "zfs" ];

  boot.extraModprobeConfig = ''
    options iwlmvm power_scheme=1
    options iwlwifi power_save=0
  '';

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.memtest86.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "bingo";
  networking.hostId = "d9b1725a";

  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    allowPing = true;
  };

  time.timeZone = "America/Chicago";

  nix.settings.max-jobs = 4;
  nix.settings.cores = 2;

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

  services.tailscale.enable = true;

}
