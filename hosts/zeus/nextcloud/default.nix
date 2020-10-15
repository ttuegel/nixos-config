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

  services.nextcloud = {
    enable = true;
    hostName = "next.tuegel.cloud";
    nginx.enable = true;
    config = {
      dbtype = "pgsql";
      dbuser = "nextcloud";
      dbhost = "/run/postgresql";
      dbname = "nextcloud";
      adminuser = "root";
      adminpassFile = "/etc/nixos/hosts/zeus/nextcloud/adminpass";
    };
  };

}
