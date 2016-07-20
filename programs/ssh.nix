{ config, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    permitRootLogin = "no";
    ports = [ 2222 ];
  };

  networking.firewall.allowedTCPPorts = [ 2222 ];
  networking.firewall.allowedUDPPorts = [ 2222 ];
}
