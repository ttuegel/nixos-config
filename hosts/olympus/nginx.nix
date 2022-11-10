{ config, lib, pkgs, ... }:

{
  security.acme = {
    defaults.email = "ttuegel@mailbox.org";
    acceptTerms = true;
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts."next.tuegel.cloud" = {
      enableACME = true;
      forceSSL = true;
      http2 = true;

      locations."/" = {
        proxyPass = "http://10.100.0.2";
        priority = "2000";
        extraConfig = ''
          client_max_body_size 1G;
        '';
      };
    };
  };
}
