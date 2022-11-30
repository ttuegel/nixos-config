{ config, lib, pkgs, ... }:

{
  boot.supportedFilesystems = [ "zfs" ];
  boot.kernelParams = [ "zfs.zfs_arc_max=2147483648" ];
  networking.hostId = "63f13d60";
  services.zfs = {
    autoScrub.enable = true;
    autoSnapshot.enable = true;
    autoSnapshot.daily = 90;
  };
}
