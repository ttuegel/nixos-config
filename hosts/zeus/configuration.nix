{ config, lib, pkgs, ... }:

{
  imports = [
    ../../config
    ../../features/avahi.nix
    ../../features/dvorak-swapcaps
    ../../features/ecryptfs.nix
    ../../features/fstrim.nix
    ../../features/nix-serve.nix
    ../../features/zerotier.nix
    ../../programs/ssh.nix
    ../../programs/nix.nix
    ../../programs/dropbox.nix
    ../../programs/emacs.nix
    ../../programs/fish.nix
    ./nextcloud
    ./zfs.nix
  ];

  ### HARDWARE

  boot.loader.systemd-boot.enable = true;

  boot.initrd.availableKernelModules = [ "ahci" "ohci_pci" "ehci_pci" "xhci_pci" "usbhid" ];

  powerManagement.cpuFreqGovernor = "ondemand";

  ### HARDWARE: VIDEO

  boot.kernelModules = [ "kvm-amd" ];
  boot.kernelParams = [ "radeon.si_support=0" "amdgpu.si_support=1" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.opengl.driSupport32Bit = true;
  hardware.enableAllFirmware = true;

  ### HARDWARE: HIDPI

  hardware.video.hidpi.enable = true;
  boot.loader.systemd-boot.consoleMode = "keep";
  console.earlySetup = false;

  ### FILESYSTEMS

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/134db4cf-4a7f-4949-8b53-8d1f01c6bce4";
      fsType = "ext4";
      options = [ "rw" "data=ordered" "noatime" ];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/A9C8-33F6";
      fsType = "vfat";
    };
  };

  ### NETWORKING

  networking.hostName = "zeus";

  networking.firewall = {
    enable = true;
    allowPing = true;
  };

  networking.networkmanager.enable = true;

  ### NIX

  nix.maxJobs = 4;
  services.nix-serve.secretKeyFile = "/var/lib/nix-serve/tuegel.mooo.com-1.key";

  ### ENVIRONMENT

  time.timeZone = "America/Chicago";

  system.stateVersion = "20.09";

  documentation.nixos.enable = false; # It's always broken anyway.
  programs.command-not-found.enable = false;
  programs.bash.enableCompletion = false;

  environment.systemPackages = with pkgs; [
    cryptsetup keyutils
    gnupg pinentry-curses
    pass
    direnv lorri cachix niv
    fd ripgrep
    git vcsh
    htop
    repos
    tmux
    wireguard
  ];

  networking.wireguard = {
    enable = true;
    interfaces.wg0 = {
      ips = [ "10.100.0.2/24" ];
      privateKeyFile = "/var/lib/wireguard/private.key";
      peers = [
        {
          publicKey = "UpeZmYMsVtEbCMNu2BhVcdln/DP8fuLtdVOYArM14GU=";
          allowedIPs = [ "10.100.0.0/24" ];
          endpoint = "45.76.23.5:51820";
          persistentKeepalive = 16;
        }
      ];
    };
  };

}
