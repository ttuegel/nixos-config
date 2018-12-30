{ config, lib, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ../config
    ../features/dvorak-swapcaps
    ./gitolite.nix
    ../programs/ssh.nix
    ./samba.nix
  ];

  system.stateVersion = "17.09";

  boot.initrd.availableKernelModules = [
    "uhci_hcd" "ehci_pci" "ata_piix" "ahci" "firewire_ohci" "sd_mod" "sr_mod"
    "sdhci_pci"
  ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

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

  swapDevices = [ ];

  fileSystems.extrn = {
    label = "tuegel2";
    mountPoint = "/mnt/extrn";
    options = [ "nofail" ];
  };

  networking.hostName = "legion";

  time.timeZone = "America/Chicago";

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
      "http://mugen.lan:5000/"
    ];
    binaryCachePublicKeys = [
      "tuegel.mooo.com-1:hZ9VCbn2eRfZl3VVYxkFakWH2SSA18vDv87xxT7BKus="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
    nixPath = [
      "nixpkgs=/etc/nixos/nixpkgs"
      "nixos-config=/etc/nixos/configuration.nix"
    ];
    maxJobs = lib.mkDefault 2;
  };

  services.logind.extraConfig = ''
    HandleLidSwitch=ignore
  '';

  powerManagement.cpuFreqGovernor = "ondemand";

  networking.firewall = {
    enable = false;
    allowPing = true;
  };
}
