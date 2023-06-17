{ config, lib, pkgs, ... }:

{
  boot.supportedFilesystems = [ "zfs" ];
  boot.kernelParams = [ "zfs.zfs_arc_max=536870912" ];
  networking.hostId = "2ab18e0f";
  services.zfs = {
    autoScrub.enable = true;
    autoSnapshot.enable = true;
  };
}
