{ config, lib, pkgs, secrets, ... }:

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

  age.secrets.nextcloud-admin-password = {
    file = "${secrets}/hosts/zeus/nextcloud-admin-password";
    owner = "nextcloud";
    group = "nextcloud";
  };

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud26;
    hostName = "next.tuegel.cloud";
    config = {
      dbtype = "pgsql";
      dbuser = "nextcloud";
      dbhost = "/run/postgresql";
      dbname = "nextcloud";
      adminuser = "root";
      adminpassFile = config.age.secrets.nextcloud-admin-password.path;
      trustedProxies = [
        "10.100.0.0/24"
        "45.76.23.5"
      ];
      overwriteProtocol = "https";
    };
    enableBrokenCiphersForSSE = false;
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
