{ ... }:

{
  services.samba = {
    enable = true;
    syncPasswordsByPam = true;
    shares = {
      "public" = {
        "browseable" = "yes";
        "guest ok" = "no";
        "path" = "/mnt/extrn/users";
        "read only" = "no";
      };
    };
  };
  networking.firewall = {
    allowedTCPPorts = [ 139 445 ];
    allowedUDPPorts = [ 137 138 ];
  };
}
