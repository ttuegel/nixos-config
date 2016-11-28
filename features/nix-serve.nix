{ ... }:

{
  networking.firewall.allowedTCPPorts = [ 5000 ];

  services.nix-serve = {
    enable = true;
    secretKeyFile = "/var/lib/nix-serve/tuegel.mooo.com-1.key";
  };
}
