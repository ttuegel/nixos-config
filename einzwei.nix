# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ <nixos/modules/installer/scan/not-detected.nix>
      ./fonts.nix
      ./passwords.nix
    ];
  boot.initrd.availableKernelModules = [ "uhci_hcd" "ehci_hcd" "ata_piix" "ahci" "firewire_ohci" "usb_storage" ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";

  fileSystems."/" =
    { device = "/dev/sda2";
      fsType = "ext4";
      options = "rw,data=ordered,relatime";
    };

  fileSystems.extrn = {
    label = "tuegel2";
    mountPoint = "/mnt/extrn";
  };

  swapDevices =
    [ { device = "/dev/sda1"; }
    ];

  hardware.pulseaudio.enable = true;

  # Select internationalisation properties.
  i18n = {
    consoleKeyMap = "dvorak";
    defaultLocale = "en_US.UTF-8";
  };

  networking.hostName = "einzwei"; # Define your hostname.

  nix = {
    binaryCaches = [
      "http://cache.nixos.org/"
      "http://hydra.nixos.org/"
    ];
    daemonIONiceLevel = 7;
    daemonNiceLevel = 19;
    maxJobs = 1;
  };

  nixpkgs.config = {
    allowUnfree = true;
    pulseaudio = true;
  };

  programs.zsh.enable = true;

  # List services that you want to enable:

  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    permitRootLogin = "no";
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    resolutions = [ { x = 1360; y = 768; } ];
    synaptics = {
      enable = true;
      twoFingerScroll = true;
      vertEdgeScroll = false;
      additionalOptions = ''
        Option "LockedDrags" "True"
        Option "LockedDragTimeout" "500"
      '';
    };
  };

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.kdm.enable = true;
  services.xserver.desktopManager.kde4.enable = true;

  time.timeZone = "America/Chicago";

  users.defaultUserShell = "/var/run/current-system/sw/bin/bash";

  users.mutableUsers = false;
  users.extraUsers = {
    ttuegel = {
      uid = 1000;
      description = "Thomas Tuegel";
      home = "/home/ttuegel";
      shell = "/var/run/current-system/sw/bin/zsh";
      group = "users";
      extraGroups = [ "wheel" ];
    };
    xbmc = {
      uid = 1001;
      description = "Guest Account";
      home = "/home/xbmc";
      group = "users";
    };
  };

  environment.systemPackages = with pkgs; [
    git
    mosh
  ];
}
