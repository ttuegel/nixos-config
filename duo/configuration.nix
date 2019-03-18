{ config, lib, pkgs, ... }:

{
  imports = [
    <nixos/modules/installer/scan/not-detected.nix>
    ../config
    ../features/desktop.nix
    ../features/dvorak-swapcaps
    ../features/ecryptfs.nix
    ../features/fstrim.nix
    ../features/hplip.nix
    ../features/synaptics.nix
    ../programs
    ../programs/dropbox.nix
    ../programs/emacs.nix
    ../programs/fish.nix
  ];

  boot.initrd.availableKernelModules = [ "ehci_hcd" "ahci" ];

  boot.kernelModules = [ "kvm-intel" ];
  services.xserver.videoDrivers = [ "modesetting" ];
  hardware.opengl.driSupport32Bit = true;

  # Flakey 802.11n support
  boot.extraModprobeConfig = ''
    options iwlwifi 11n_disable=1
  '';

  # Bluetooth support
  hardware.bluetooth.enable = true;
  # A2DP profile
  hardware.pulseaudio.package = pkgs.pulseaudioFull;

  hardware.trackpoint = {
    enable = true;
    emulateWheel = true;
  };

  services.thermald.enable = true;
  services.thinkfan.enable = true;

  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
  };

  boot.tmpOnTmpfs = false;

  fileSystems."/" = {
    device = "/dev/sda3";
    fsType = "ext4";
    options = [ "rw" "data=ordered" "noatime" ];
  };

  networking.hostName = "duo";
  networking.networkmanager.enable = true;

  nix.maxJobs = 2;

  time.timeZone = "America/Chicago";

  system.stateVersion = "18.03";
}
