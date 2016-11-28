{ config, lib, pkgs, ... }:

{
  imports = [
    <nixos/modules/installer/scan/not-detected.nix>
    ./config
    ./features/desktop.nix
    ./features/dvorak-swapcaps
    ./features/fstrim.nix
    ./features/ecryptfs.nix
    ./features/hplip
    ./features/synaptics.nix
    ./programs
    ./programs/dropbox.nix
    ./programs/emacs.nix
  ];

  boot.initrd.availableKernelModules = [
    "ehci_hcd"
    "ahci"
  ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
  };
  boot.extraModulePackages = [ ];

  # Reduce wear on SSD
  boot.tmpOnTmpfs = true;

  fileSystems."/" = {
    device = "/dev/sda3";
    fsType = "ext4";
    options = [ "rw" "data=ordered" "noatime" ];
  };

  hardware.opengl.driSupport32Bit = true;

  networking.hostName = "duo";
  networking.networkmanager.enable = true;

  nix.maxJobs = 2;

  services.thermald.enable = true;
  services.thinkfan.enable = true;

  time.timeZone = "America/Chicago";
}
