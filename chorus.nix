{ config, pkgs, ... }:

{
  imports = [
    <nixos/modules/installer/scan/not-detected.nix>
    ./config
    ./features/dvorak-swapcaps
    ./features/gitolite
    ./programs/emacs.nix
    ./programs/ssh.nix
  ];

  boot.initrd.availableKernelModules = [
    "ehci_hcd"
    "ahci"
  ];
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
  };

  fileSystems."/" = {
    device = "/dev/sda1";
    fsType = "ext4";
    options = [ "rw" "data=ordered" "relatime" ];
  };

  fileSystems.extrn = {
    label = "tuegel2";
    mountPoint = "/mnt/extrn";
    options = [ "nofail" ];
  };

  networking.hostName = "chorus";

  networking.wireless.enable = true;

  time.timeZone = "America/Chicago";

  fonts.fontconfig.enable = false;
  services.xserver.enable = false;

  environment.systemPackages = with pkgs; [
    git
    haskellPackages.git-annex
    mr
    openssl # for certificate generation
    vcsh
  ];

  nix = {
    binaryCaches = [
      "http://cache.nixos.org/"
    ];
    trustedBinaryCaches = [
      "http://192.168.0.3:5000/"
    ];
    binaryCachePublicKeys = [
      "tuegel.mooo.com-1:hZ9VCbn2eRfZl3VVYxkFakWH2SSA18vDv87xxT7BKus="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
    nixPath = [
      "nixpkgs=/etc/nixos/nixpkgs"
      "nixos=/etc/nixos/nixpkgs/nixos"
      "nixos-config=/etc/nixos/configuration.nix"
    ];
  };

  users.extraUsers.ttuegel.shell = "/run/current-system/sw/bin/bash";

  services.logind.extraConfig = ''
    HandleLidSwitch=ignore
  '';


  # DHCP server, DNS cache, and routing

  ## Keep link-local traffic off the wireless.
  networking.extraHosts = ''
    192.168.1.1 tuegel.mooo.com
  '';

  networking.firewall = {
    enable = false;
    allowPing = true;
  };

  ## Local subnet over ethernet port
  networking.interfaces.enp2s0.ip4 = [ { address = "192.168.1.1"; prefixLength = 24; } ];

  ## DHCP server and DNS cache
  services.dnsmasq = {
    enable = true;
    extraConfig = ''
      interface=enp2s0
      dhcp-range=192.168.1.2,192.168.1.127
      dhcp-host=DEV1B82FE,192.168.1.2
    '';
    resolveLocalQueries = false;
  };

  ## Routing
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = true;
  };


  # Quassel IRC daemon

  ## PostgreSQL backend
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql94;
  };

  ## Quassel daemon
  services.quassel = {
    enable = true;
    interfaces = [ "0.0.0.0" ];
  };
  ### Ensure PostgreSQL is started before Quassel.
  systemd.services.quassel.after = [ "postgresql.service" ];
}
