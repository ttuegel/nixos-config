# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ <nixos/modules/installer/scan/not-detected.nix>
      ./passwords.nix
    ];
  boot.initrd.availableKernelModules = [
    "uhci_hcd" "ehci_hcd" "ata_piix" "ahci" "firewire_ohci" "usb_storage"
  ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";

  fileSystems."/" = {
    device = "/dev/sda2";
    fsType = "ext4";
    options = "rw,data=ordered,relatime";
  };

  fileSystems.extrn = {
    label = "tuegel2";
    mountPoint = "/mnt/extrn";
  };

  swapDevices = [
    { device = "/dev/sda1"; }
  ];

  hardware.pulseaudio.enable = true;

  # Select internationalisation properties.
  i18n = {
    consoleKeyMap = "dvorak";
    defaultLocale = "en_US.UTF-8";
  };

  networking.firewall.allowedTCPPorts = [ 139 445 4242 ];
  networking.firewall.allowedUDPPorts = [ 137 138 ];
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

    haskellPackageOverrides = self: super: {
      /* Fixes for git-annex on i686-linux */
      asn1-encoding = with pkgs.pkgs.haskell-ng.lib;
        if builtins.currentSystem == "i686-linux"
          then dontCheck super.asn1-encoding
        else super.asn1-encoding;

      c2hs = with pkgs.pkgs.haskell-ng.lib;
        if builtins.currentSystem == "i686-linux"
          then dontCheck super.c2hs
        else super.c2hs;

      bloomfilter = with pkgs.pkgs.haskell-ng.lib;
        if builtins.currentSystem == "i686-linux"
          then dontCheck super.bloomfilter
        else super.bloomfilter;
    };
  };

  programs.zsh.enable = true;

  # List services that you want to enable:

  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  services.gitolite.enable = true;
  services.gitolite.adminPubkey = builtins.readFile ./gitolite-admin.pub;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    permitRootLogin = "no";
  };

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql94;
  };

  services.quassel = {
    enable = true;
    interface = "0.0.0.0";
  };

  services.samba = {
    enable = true;
    extraConfig = ''
      # [global] continuing global section here, section is started by nix to set pids etc

      smb passwd file = /etc/samba/passwd

      # is this useful ?
      domain master = auto

      encrypt passwords = Yes
      client plaintext auth = No

      # yes: if you use this you probably also want to enable syncPasswordsByPam
      # no: You can still use the pam password database. However
      # passwords will be sent plain text on network (discouraged)

      workgroup = Users
      server string = %h
      comment = Samba
      log file = /var/log/samba/log.%m
      log level = 10
      max log size = 50000
      security = ${config.services.samba.securityType}

      client lanman auth = Yes
      dns proxy = no
      invalid users = root
      passdb backend = tdbsam
      passwd program = /usr/bin/passwd %u

      [homes]
      read only = no

      [xbmc]
      path = /mnt/extrn/xbmc
      read only = no
    '';
  };

  # Enable the X11 windowing system.
  services.xserver = {
    displayManager.slim = {
      autoLogin = true;
      defaultUser = "xbmc";
      enable = true;
    };
    desktopManager.kde4.enable = true;
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
      shell = "/var/run/current-system/sw/bin/zsh";
    };
  };

  environment.systemPackages = with pkgs; [
    emacs
    firefoxWrapper
    git
    gitAndTools.gitAnnex
    kde4.kmix
    keychain
    mr
    rxvt_unicode.terminfo
    samba
    tmux
    vcsh
    vlc
  ];

  environment.variables =
    {
      NIX_PATH = pkgs.lib.mkOverride 0 [
        "nixpkgs=/etc/nixos/nixpkgs"
        "nixos=/etc/nixos/nixpkgs/nixos"
        "nixos-config=/etc/nixos/configuration.nix"
      ];
    };
}
