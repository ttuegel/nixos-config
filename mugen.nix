{ config, pkgs, ... }:

{
  imports =
    [ <nixos/modules/installer/scan/not-detected.nix>
      <nixos/modules/programs/virtualbox.nix>
      ./common.nix
    ];

  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";

    # Define an extra entry for Gentoo
    extraEntries = ''
      menuentry "Gentoo" {
        insmod ext2
        search --set=root --label gentoo --hint hd0,msdos1
        configfile /boot/grub/grub.cfg
      }
    '';
  };

  boot.initrd.availableKernelModules = [
    "ahci"
    "ehci_hcd"
    "firewire_ohci"
    "ohci_hcd"
    "pata_atiixp"
  ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  environment.systemPackages = [
    pkgs.hplip
  ];

  fileSystems."/" =
    { device = "/dev/sda3";
      fsType = "ext4";
      options = "rw,data=ordered,relatime";
    };

  networking.hostName = "mugen";

  nix.maxJobs = 4;
  nix.daemonIONiceLevel = 7;
  nix.daemonNiceLevel = 19;

  services.vsftpd = {
    enable = true;
    anonymousUser = true;
  };

  swapDevices = [ { device = "/dev/sda4"; } ];

  systemd.services.mugen-virtualbox =
    let
      inherit (pkgs.linuxPackages) virtualbox;
    in {
      description = "Virtualbox Headless Print Server";
      path = [ virtualbox ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${virtualbox}/bin/VBoxHeadless -s Ubuntu";
        ExecStop = "${virtualbox}/bin/VBoxManage controlvm Ubuntu poweroff";
        User = "ttuegel";
    };
  };
}
