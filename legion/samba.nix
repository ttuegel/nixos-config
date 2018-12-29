{ ... }:

{
  services.samba = {
    enable = true;
    shares = {
      "public" = {
        "browseable" = "yes";
        "guest ok" = "yes";
        "guest only" = "yes";
        "path" = "/mnt/extrn/users";
      };
    };
  };
  networking.firewall = {
    allowedTCPPorts = [ 139 445 ];
    allowedUDPPorts = [ 137 138 ];
  };
}
