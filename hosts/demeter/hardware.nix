{ config, lib, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod"
  ];
  boot.kernelModules = [ "kvm-amd" ];
  services.xserver.videoDrivers = [ "amdgpu" ];

  boot.loader.systemd-boot.enable = true;
  boot.cleanTmpDir = true;

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/3c1ec4f3-e3c5-42dd-ac3a-b247322cb0a0";
      fsType = "ext4";
      options = [ "rw" "data=ordered" "noatime" ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/4146-A7EC";
      fsType = "vfat";
    };
  };
}
