{ ... }:

{
  networking.firewall.allowedTCPPorts = [ 5000 ];
  services.nix-serve.enable = true;
}
