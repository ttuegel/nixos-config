{ secrets, ... }:

{

  fileSystems."/var/lib/gitolite" = {
    device = "tank/gitolite";
    fsType = "zfs";
  };

  services.gitolite = {
    enable = true;
    adminPubkey = builtins.readFile "${secrets}/hosts/zeus/gitolite-admin.pub";
  };
}
