{ config, pkgs, ... }:

{
  imports = [
    <nixos/modules/installer/scan/not-detected.nix>
    ./config
    ./features/desktop.nix
    ./features/dvorak-swapcaps
    ./features/ecryptfs.nix
    ./features/hplip
    ./features/nix-serve.nix
    ./programs
    ./programs/dropbox.nix
    ./programs/emacs.nix
    ./programs/gpg-agent.nix
  ];

  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
  };

  boot.cleanTmpDir = true;
  boot.initrd.availableKernelModules = [
    "ahci"
    "ehci_hcd"
    "firewire_ohci"
    "ohci_hcd"
    "pata_atiixp"
  ];
  boot.kernelModules = [ "kvm-amd" "radeon" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/sda3";
      fsType = "ext4";
      options = [ "rw" "data=ordered" "relatime" ];
    };

  networking = {
    hostName = "mugen";
    wireless.enable = true;
    firewall = {
      enable = false;
      allowPing = true;
      allowedTCPPorts = [ 631 5000 8080 ];
    };
  };

  nix.maxJobs = 4;

  time.timeZone = "America/Chicago";
}
