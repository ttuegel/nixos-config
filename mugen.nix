{ config, pkgs, ... }:

{
  imports =
    [ <nixos/modules/installer/scan/not-detected.nix>
      ./common.nix
    ];

  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
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
  networking.firewall.allowedTCPPorts = [ 631 8080 ];

  nix.maxJobs = 4;
  nix.daemonIONiceLevel = 7;
  nix.daemonNiceLevel = 19;
  nix.extraOptions = ''
    build-cores = 0
    gc-keep-outputs = true
    gc-keep-derivations = true
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
