{ config, lib, pkgs, ... }:

{
  imports = [ ../../modules/laminar.nix ];

  fileSystems."/var/lib/laminar" = {
    device = "tank/laminar";
    fsType = "zfs";
  };

}
