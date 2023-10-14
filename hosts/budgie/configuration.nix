{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./zfs.nix
    ../../modules/fish.nix
    ../../modules/nix.nix
    ../../modules/ssh.nix
    ../../modules/users.nix
    ../../modules/zerotier.nix
  ];

  boot.initrd.availableKernelModules = [ "hv_balloon" "hv_netvsc" "hv_storvsc" "hv_utils" "hv_vmbus" ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda"; # or "nodev" for efi only

  boot.zfs.forceImportRoot = false;

  networking.hostName = "budgie";

  # Set your time zone.
  time.timeZone = "America/Chicago";

  environment.systemPackages = with pkgs; [
    git htop nano
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "no";
  security.pam.enableSSHAgentAuth = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
