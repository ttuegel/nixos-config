{ config, pkgs, ... }:

{
  imports = [
    <nixos/modules/installer/scan/not-detected.nix>
    ./config
    ./features/desktop.nix
    ./features/dvorak-swapcaps
    ./features/hplip
    ./programs
    ./programs/emacs.nix
    ./programs/gpg-agent.nix
  ];

  boot.initrd.availableKernelModules = [
    "ehci_hcd"
    "ahci"
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
  boot.tmpOnTmpfs = true;

  fileSystems."/" = {
    device = "/dev/sda3";
    fsType = "ext4";
    options = "rw,data=ordered,relatime,discard";
  };

  networking.hostName = "duo";
  networking.networkmanager.enable = true;

  swapDevices = [ { device = "/dev/sda2"; } ];

  nix.maxJobs = 2;
  nix.daemonIONiceLevel = 7;
  nix.daemonNiceLevel = 19;
  nix.extraOptions = ''
    build-cores = 0
    gc-keep-derivations = true
  '';

  services.thinkfan.enable = true;

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

  time.timeZone = "America/Chicago";
}
