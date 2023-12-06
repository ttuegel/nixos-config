{ config, ... }:

{
  services.forgejo = {
    enable = true;
    database = {
      type = "postgres";
      createDatabase = true;
    };
    settings.session.COOKIE_SECURE = true;
    settings.server.DOMAIN = "forge.enchanted.earth";
  };

  services.nginx.virtualHosts."forge.enchanted.earth" = {
    locations."/" = {
      proxyPass =
        let inherit (config.services.forgejo.settings.server) PROTOCOL HTTP_ADDR HTTP_PORT;
        in "${PROTOCOL}://${HTTP_ADDR}:${builtins.toString HTTP_PORT}";
      recommendedProxySettings = true;
    };
    enableACME = true;
    forceSSL = true;
  };
}
