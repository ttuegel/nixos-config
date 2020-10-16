{ config, lib, pkgs, ... }:

{
  security.acme = {
    email = "ttuegel@mailbox.org";
    acceptTerms = true;
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;

    virtualHosts."next.tuegel.cloud" = {
      enableACME = true;
      forceSSL = true;

      locations."/" = {
        proxyPass = "http://10.100.0.2";
        priority = "2000";
      };
    };
  };
}
