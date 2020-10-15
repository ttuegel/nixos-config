{ config, lib, pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "nextcloud" ];
    ensureUsers = [
      {
        name = "nextcloud";
        ensurePermissions."DATABASE nextcloud" = "ALL PRIVILEGES";
      }
    ];
  };

  fileSystems."/var/lib/postgresql" = {
    device = "tank/postgresql";
    fsType = "zfs";
  };
}
