{ config, pkgs, ... }:

{
  imports = [
    <nixos/modules/installer/scan/not-detected.nix>
    ./config
    ./features/dvorak-swapcaps
    ./programs/emacs.nix
    ./programs/ssh.nix
  ];

  boot.initrd.availableKernelModules = [
    "ehci_hcd"
    "ahci"
  ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
  };
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/sda1";
    fsType = "ext4";
    options = [ "rw" "data=ordered" "relatime" ];
  };

  networking = {
    hostName = "chorus";
    wireless.enable = true;
    firewall = {
      enable = false;
      allowPing = true;
    };
  };

  time.timeZone = "America/Chicago";

  fonts.fontconfig.enable = false;
  services.xserver.enable = false;

  environment.systemPackages = with pkgs; [
    git
    mr
    vcsh
  ];

  nix = {
    nixPath = [
      "nixpkgs=/etc/nixos/nixpkgs"
      "nixos=/etc/nixos/nixpkgs/nixos"
      "nixos-config=/etc/nixos/configuration.nix"
    ];
  };

  users.extraUsers.ttuegel.shell = "/run/current-system/sw/bin/bash";
}
