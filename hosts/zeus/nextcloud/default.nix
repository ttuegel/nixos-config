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
    package = pkgs.nextcloud23;
    hostName = "next.tuegel.cloud";
    config = {
      dbtype = "pgsql";
      dbuser = "nextcloud";
      dbhost = "/run/postgresql";
      dbname = "nextcloud";
      adminuser = "root";
      adminpassFile = "/var/lib/nextcloud/adminpass";
      trustedProxies = [
        "10.100.0.0/24"
        "45.76.23.5"
      ];
      overwriteProtocol = "https";
    };
  };

  fileSystems."/var/lib/nextcloud" = {
    device = "tank/nextcloud";
    fsType = "zfs";
  };

  systemd.services."nextcloud-setup" = {
    requires = ["postgresql.service"];
    after = ["postgresql.service"];
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];

}
