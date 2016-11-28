{ config, pkgs, ... }:

{
  imports = [
    <nixos/modules/installer/scan/not-detected.nix>
    ./config
    ./features/desktop.nix
    ./features/dvorak-swapcaps
    ./features/ecryptfs.nix
    ./features/fstrim.nix
    ./features/hplip
    ./features/nix-serve.nix
    ./programs
    ./programs/dropbox.nix
    ./programs/emacs.nix
  ];

  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sdb";
  };

  boot.tmpOnTmpfs = true;
  boot.initrd.availableKernelModules = [
    "ahci"
    "ehci_hcd"
    "ohci_hcd"
  ];
  boot.kernelModules = [ "kvm-amd" ];

  fileSystems = {
    "/" = {
      device = "/dev/sdb1";
      fsType = "ext4";
      options = [ "rw" "data=ordered" "noatime" ];
    };

    "/hdd" = {
      device = "/dev/sda3";
      fsType = "ext4";
      options = [ "rw" "data=ordered" "noatime" ];
    };

    "/home" = { device = "/hdd/home"; options = [ "bind" ]; };
  };

  hardware.opengl.driSupport32Bit = true;

  networking = {
    hostName = "mugen";
    wireless.enable = true;
    firewall = {
      enable = true;
      allowPing = true;
      allowedTCPPorts = [ 5000 ];
    };
  };

  nix.maxJobs = 4;

  powerManagement.cpuFreqGovernor = "ondemand";

  time.timeZone = "America/Chicago";

  virtualisation.virtualbox.host.enable = true;
}
