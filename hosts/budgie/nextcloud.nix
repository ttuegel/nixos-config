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

  age.secrets.nextcloud-backblaze-secret = {
    file = "${secrets}/hosts/budgie/nextcloud-backblaze-secret";
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
    phpOptions = {
      "opcache.interned_strings_buffer" = "16";
    };
    config = {
      dbtype = "pgsql";
      adminuser = "root";
      adminpassFile = config.age.secrets.nextcloud-admin-password.path;
      objectstore.s3 = {
        enable = true;
        hostname = "s3.us-west-004.backblazeb2.com";
        bucket = "cloud-enchanted-earth";
        usePathStyle = true;
        autocreate = false;
        key = "004e252d0df953f0000000002";
        secretFile = config.age.secrets.nextcloud-backblaze-secret.path;
      };
    };
    extraOptions = {
      # Bulk upload is broken at least until Nextcloud 28.
      # Worse, the feature makes the wrong trade-off: gain some speed, but lose
      # all resilience, i.e. the ability to resume uploads.
      "bulkupload.enabled" = false;
    };
  };

  services.nginx.virtualHosts.${config.services.nextcloud.hostName} = {
    forceSSL = true;
    enableACME = true;
  };
  security.acme.acceptTerms = true;
  security.acme.defaults.email = "ttuegel+acme@mailbox.org";

  systemd.services."nextcloud-setup" = {
    requires = ["postgresql.service"];
    after = ["postgresql.service"];
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];

}
