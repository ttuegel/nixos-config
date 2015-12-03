{ ... }:

{
  services.gitolite = {
    enable = true;
    adminPubkey = builtins.readFile ./gitolite-admin.pub;
  };
}
