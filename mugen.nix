{ config, pkgs, ... }:

{
  imports = [
    ./config
    ./features/desktop.nix
    ./features/dvorak-swapcaps
    ./features/ecryptfs.nix
    ./features/fstrim.nix
    ./features/hplip
    ./features/nix-serve.nix
    ./programs
    ./programs/dropbox.nix
    ./programs/emacs.nix
    ./programs/mathematica.nix
  ];

  boot.initrd.availableKernelModules = [ "ahci" "ehci_hcd" "ohci_hcd" ];
  boot.kernelModules = [ "kvm-amd" ];
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

  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.opengl.driSupport32Bit = true;

  networking.hostName = "mugen";
  networking.wireless.enable = true;

  networking.firewall = {
    enable = true;
    allowPing = true;
  };

  nix.maxJobs = 8;

  powerManagement.cpuFreqGovernor = "ondemand";

  programs.zsh.enable = true;

  time.timeZone = "America/Chicago";

  environment.systemPackages = with pkgs; [
    (steam.override { newStdcpp = true; })
  ];
  hardware.pulseaudio.support32Bit = true;
}
