{ config, pkgs, ... }:

{
  imports = [
    <nixos/modules/installer/scan/not-detected.nix>
    ./config
    ./features/desktop.nix
    ./features/dvorak-swapcaps
    ./features/hplip
    ./features/synaptics.nix
    ./programs
    ./programs/dropbox.nix
    ./programs/emacs.nix
    ./programs/gpg-agent.nix
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
  boot.kernel.sysctl = {
    "vm.swappiness" = 1;
  };
  boot.tmpOnTmpfs = true;

  fileSystems."/" = {
    device = "/dev/sda3";
    fsType = "ext4";
    options = [ "rw" "data=ordered" "relatime" "discard" ];
  };

  networking.hostName = "duo";
  networking.networkmanager.enable = true;

  swapDevices = [ { device = "/dev/sda2"; } ];

  nix.maxJobs = 2;

  services.thinkfan.enable = true;

  time.timeZone = "America/Chicago";
}
