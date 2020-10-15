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
    config = {
      dbtype = "pgsql";
      dbuser = "nextcloud";
      dbhost = "/run/postgresql";
      dbname = "nextcloud";
      adminuser = "root";
      adminpassFile = "/etc/nixos/hosts/zeus/nextcloud/adminpass";
    };
  };

  systemd.services."nextcloud-setup" = {
    requires = ["postgresql.service"];
    after = ["postgresql.service"];
  };

}
