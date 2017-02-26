{ config, pkgs, ... }:

{
  imports = [
    <nixos/modules/installer/scan/not-detected.nix>
    ./config
    ./features/desktop.nix
    ./features/dvorak-swapcaps
    ./features/ecryptfs.nix
    ./features/es.nix
    ./features/fstrim.nix
    ./features/hplip
    ./features/nix-serve.nix
    ./programs
    ./programs/dropbox.nix
    ./programs/emacs.nix
  ];

  boot.initrd.availableKernelModules = [ "ahci" "ehci_hcd" "ohci_hcd" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.loader.systemd-boot.enable = true;

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

    "/tmp" = { device = "/hdd/tmp"; options = [ "bind" ]; };
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

  time.timeZone = "America/Chicago";

  environment.systemPackages = with pkgs; [
    (steam.override { newStdcpp = true; })
  ];
  hardware.pulseaudio.support32Bit = true;

  nixpkgs.config.packageOverrides = super: let self = super.pkgs; in {
    mesa_drivers =
      let mesa = super.mesa_noglu.override {
            grsecEnabled = false;
            galliumDrivers = [ "radeonsi" ];
            driDrivers = [];
            vulkanDrivers = [];
          };
      in mesa.drivers;
  };
}
