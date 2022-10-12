{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../../modules/config.nix
    ../../modules/desktop.nix
    ../../modules/dvorak-swapcaps
    ../../modules/ecryptfs.nix
    ../../modules/fstrim.nix
    ../../modules/gnupg.nix
    ../../modules/hplip.nix
    ../../modules/zerotier.nix
    ../../modules/programs.nix
    ../../modules/emacs.nix
    ../../modules/fish.nix
    ../../modules/vscode.nix
    ../../modules/users.nix
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

  # DO NOT mount tmpfs on /tmp (not enough memory), but DO clean /tmp at boot.
  boot.cleanTmpDir = true;
  boot.tmpOnTmpfs = false;

  fileSystems."/" = {
    device = "/dev/sda3";
    fsType = "ext4";
    options = [ "rw" "data=ordered" "noatime" ];
  };

  networking.hostName = "dioscuri";
  networking.networkmanager.enable = true;

  nix.maxJobs = 2;
  nix.buildCores = 2;

  system.stateVersion = "18.03";

  time.timeZone = "America/Chicago";

  programs.mosh.enable = true;
}
