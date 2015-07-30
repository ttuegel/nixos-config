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

  networking.firewall = {
    enable = false;
    allowPing = true;
    allowedTCPPorts = [ 631 5000 8080 ];
  };
  networking.hostName = "mugen";
  networking.wireless.enable = true;
  networking.interfaces.enp3s0.ip4 = [ { address = "192.168.1.1"; prefixLength = 24; } ];
  services.dnsmasq = {
    enable = true;
    extraConfig = ''
      interface=enp3s0
      dhcp-range=192.168.1.2,192.168.1.254
      dhcp-host=DEV1B82FE,192.168.1.2
    '';
    resolveLocalQueries = false;
  };
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = true;
  };

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
