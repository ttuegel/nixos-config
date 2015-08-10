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

  networking = {
    hostName = "mugen";
    wireless.enable = true;
    firewall = {
      enable = false;
      allowPing = true;
      allowedTCPPorts = [ 631 5000 8080 ];
    };
    interfaces = {
      br0.ip4 = [ { address = "192.168.1.1"; prefixLength = 24; } ];
    };
    bridges = {
      br0 = { interfaces = [ "enp3s0" "tap-quassel" ]; };
    };
  };

  services.dnsmasq = {
    enable = true;
    extraConfig = ''
      interface=br0
      dhcp-range=192.168.1.2,192.168.1.127
      dhcp-host=DEV1B82FE,192.168.1.2
      dhcp-host=quassel,192.168.1.3
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

  users.extraUsers.qemu = {
    group = "users";
    home = "/var/lib/qemu";
    createHome = true;
    isSystemUser = true;
  };
  networking.interfaces.tap-quassel = {
    virtual = true;
    virtualType = "tap";
    virtualOwner = "qemu";
  };

  systemd.services = {
    qemu-quassel = {
      description = "QEMU container for Quassel Core";
      enable = true;
      serviceConfig = {
        Type = "simple";
        ExecStart =
          let inherit (import <nixos> { configuration = ./qemu/quassel.nix; }) vm;
          in "${vm}/bin/run-quassel-vm";
        User = "qemu";
        TimeoutSec = 180;
      };
      restartIfChanged = true;
      after = [ "network.target" ];
      wantedBy = [ "default.target" ];
    };
  };

  services.nix-serve.enable = true;

  services.gitolite.enable = true;
  services.gitolite.adminPubkey = builtins.readFile ./gitolite-admin.pub;

  swapDevices = [ { device = "/dev/sda4"; } ];
}
