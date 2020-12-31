{ ... }:

{
  services.gitolite = {
    enable = true;
    adminPubkey = builtins.readFile ../../secrets/hosts/legion/gitolite-admin.pub;
  };
}
