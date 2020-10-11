{ config, pkgs, ... }:

{
  imports = [
    ../../config
    ../../features/avahi.nix
    ../../features/desktop.nix
    ../../features/dvorak-swapcaps
    ../../features/ecryptfs.nix
    ../../features/fstrim.nix
    ../../features/hplip.nix
    ../../features/nix-serve.nix
    ../../features/zerotier.nix
    ../../programs
    ../../programs/dropbox.nix
    ../../programs/emacs.nix
    ../../programs/fish.nix
  ];

  boot.initrd.availableKernelModules = [ "ahci" "ehci_hcd" "ohci_hcd" ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "kvm-amd" ];
  boot.kernelParams = [ "radeon.si_support=0" "amdgpu.si_support=1" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.opengl.driSupport32Bit = true;

  boot.loader.systemd-boot.enable = true;
  boot.tmpOnTmpfs = true;

  fileSystems = {
    "/" = {
      device = "/dev/sda2";
      fsType = "ext4";
      options = [ "rw" "data=ordered" "noatime" ];
    };
    "/boot" = {
      device = "/dev/sda1";
      fsType = "vfat";
    };

    "/hdd" = {
      device = "/dev/sdb3";
      fsType = "ext4";
      options = [ "rw" "data=ordered" "noatime" ];
    };
  };

  networking.hostName = "mugen";

  networking.firewall = {
    enable = true;
    allowPing = true;
  };

  networking.networkmanager.enable = true;

  nix.maxJobs = 8;

  powerManagement.cpuFreqGovernor = "ondemand";

  time.timeZone = "America/Chicago";

  # environment.systemPackages = with pkgs; [ steam ];
  # hardware.pulseaudio.support32Bit = true;

  services.nix-serve.secretKeyFile = "/var/lib/nix-serve/tuegel.mooo.com-1.key";

  system.stateVersion = "18.03";
}
