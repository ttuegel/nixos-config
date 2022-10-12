{ ... }:

{
  services.avahi = {
    enable = true;
    ipv6 = true;
    publish.enable = true;
    nssmdns = true;
    publish = {
      userServices = true;
      addresses = true;
      domain = true;
      workstation = true;
    };
  };
}
