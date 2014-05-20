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
    pkgs.hplipWithPlugin
  ];

  fileSystems."/" =
    { device = "/dev/sda3";
      fsType = "ext4";
      options = "rw,data=ordered,relatime";
    };

  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.hplipWithPlugin ];

  networking.hostName = "mugen";
  networking.firewall.allowPing = true;
  networking.firewall.allowedTCPPorts = [ 631 ];

  nix.maxJobs = 4;
  nix.daemonIONiceLevel = 7;
  nix.daemonNiceLevel = 19;
  nix.extraOptions = ''
    build-cores = 0
  '';

  services.printing.cupsdConf = ''
    <Location />
      Order allow,deny
      Allow localhost
      Allow 192.168.1.*
    </Location>

    Listen mugen:631

    Browsing On
  '';

  services.vsftpd = {
    enable = true;
    anonymousUser = true;
  };

  swapDevices = [ { device = "/dev/sda4"; } ];
}
