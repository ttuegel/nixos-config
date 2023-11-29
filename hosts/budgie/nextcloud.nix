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

  age.secrets.nextcloud-admin-password = {
    file = "${secrets}/hosts/budgie/nextcloud-admin-password";
    owner = "nextcloud";
    group = "nextcloud";
  };

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud27;
    hostName = "cloud.enchanted.earth";
    https = true;
    database.createLocally = true;
    nginx.recommendedHttpHeaders = true;
    configureRedis = true;
    config = {
      dbtype = "pgsql";
      adminuser = "root";
      adminpassFile = config.age.secrets.nextcloud-admin-password.path;
      objectstore.s3 = {
        enable = true;
        hostname = "s3.us-west-004.backblazeb2.com";
        bucket = "cloud-enchanted-earth";
        autocreate = false;
        usePathStyle = true;
      };
    };
  };

  services.nginx.virtualHosts.${config.services.nextcloud.hostName} = {
    forceSSL = true;
    enableACME = true;
  };

  systemd.services."nextcloud-setup" = {
    requires = ["postgresql.service"];
    after = ["postgresql.service"];
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];

}
