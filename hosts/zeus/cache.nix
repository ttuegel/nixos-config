{ ... }:

{
  fileSystems."/var/www/cache" = {
    device = "tank/cache";
    fsType = "zfs";
  };

  services.nginx.virtualHosts.localhost = {
    root = "/var/www/cache";
  };
}
