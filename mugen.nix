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

  boot.cleanTmpDir = true;
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

  networking.hostName = "mugen";
  networking.firewall.allowPing = true;
  networking.firewall.allowedTCPPorts = [ 631 5000 8080 ];

  nix.maxJobs = 4;
  nix.daemonIONiceLevel = 7;
  nix.daemonNiceLevel = 19;
  nix.extraOptions = ''
    build-cores = 0
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

  services.nix-serve.enable = true;

  swapDevices = [ { device = "/dev/sda4"; } ];
}
