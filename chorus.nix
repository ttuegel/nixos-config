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

  time.timeZone = "America/Chicago";

  fonts.fontconfig.enable = false;
  services.xserver.enable = false;

  environment.systemPackages = with pkgs; [
    git
    rsync
    vcsh
    ripgrep
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

  powerManagement.cpuFreqGovernor = "ondemand";

  networking.firewall = {
    enable = false;
    allowPing = true;
  };

  nixpkgs.config.packageOverrides = super: let self = super.pkgs; in {
    mesa_drivers =
      let mesa = super.mesa_noglu.override {
            grsecEnabled = false;
            galliumDrivers = [ "intel" ];
            driDrivers = [];
            vulkanDrivers = [];
          };
      in mesa.drivers;
  };
}
