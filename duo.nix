{ config, pkgs, ... }:

{
  imports = [
    <nixos/modules/installer/scan/not-detected.nix>
    ./common.nix
  ];

  boot.initrd.availableKernelModules = [
    "uhci_hcd"
    "ehci_hcd"
    "ata_piix"
    "ahci"
    "firewire_ohci"
  ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.kernel.sysctl = {
    "vm.swappiness" = 1;
  };
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
  };
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/sda1";
    fsType = "ext4";
    options = "rw,data=ordered,relatime,discard";
  };

  networking.hostName = "duo";

  swapDevices = [ { device = "/dev/sda2"; } ];

  nix.maxJobs = 2;
  nix.daemonIONiceLevel = 7;
  nix.daemonNiceLevel = 19;
  nix.extraOptions = ''
    build-cores = 0
    gc-keep-outputs = true
    gc-keep-derivations = true
  '';

  services.thinkfan.enable = true;

  services.udev.extraRules = ''
    # set deadline scheduler for non-rotating disks
    ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="deadline"
  '';

  services.xserver.synaptics = {
    enable = true;
    # Use vertical edge scrolling as long as I'm on the Toshiba because its
    # touchpad doesn't do multi-touch :(
    twoFingerScroll = true;
    vertEdgeScroll = false;
    additionalOptions = ''
      Option "LockedDrags" "True"
      Option "LockedDragTimeout" "500"
    '';
  };
}
