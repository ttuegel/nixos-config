{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/config.nix
    ../../modules/desktop.nix
    ../../modules/dvorak-swapcaps
    ../../modules/gnupg.nix
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

  boot.kernelParams = [
    "nohibernate"
    "zfs.zfs_arc_max=1073741824"
  ];

  boot.supportedFilesystems = [ "zfs" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "maia";
  networking.hostId = "bb5a16a3";

  networking.networkmanager.enable = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;

  # Disable DHCP because it conflicts with NetworkManager.
  networking.interfaces.enp4s0.useDHCP = false;
  networking.interfaces.wlo1.useDHCP = false;

  networking.firewall = {
    enable = true;
    allowPing = true;
  };

  time.timeZone = "America/Chicago";

  nix.settings = {
    max-jobs = 8;
    cores = 2;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}
