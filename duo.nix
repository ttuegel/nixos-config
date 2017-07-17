{ config, lib, pkgs, ... }:

{
  imports = [
    <nixos/modules/installer/scan/not-detected.nix>
    ./config
    ./features/desktop.nix
    ./features/dvorak-swapcaps
    ./features/ecryptfs.nix
    ./features/fstrim.nix
    ./features/hplip
    ./features/synaptics.nix
    ./programs
    ./programs/dropbox.nix
    ./programs/emacs.nix
    ./programs/mathematica
  ];

  boot.initrd.availableKernelModules = [ "ehci_hcd" "ahci" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
  };
  boot.tmpOnTmpfs = true;
  # Flakey 802.11n support
  boot.extraModprobeConfig = ''
    options iwlwifi 11n_disable=1
  '';

  fileSystems."/" = {
    device = "/dev/sda3";
    fsType = "ext4";
    options = [ "rw" "data=ordered" "noatime" ];
  };

  hardware.opengl.driSupport32Bit = true;

  networking.hostName = "duo";
  networking.networkmanager.enable = true;

  nix.maxJobs = 2;

  programs.zsh.enable = true;

  services.thermald.enable = true;
  services.thinkfan.enable = true;

  time.timeZone = "America/Chicago";
}
