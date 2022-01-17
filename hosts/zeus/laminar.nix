{ config, lib, pkgs, ... }:

{
  imports = [ ../../features/laminar.nix ];

  fileSystems."/var/lib/laminar" = {
    device = "tank/laminar";
    fsType = "zfs";
  };

}
