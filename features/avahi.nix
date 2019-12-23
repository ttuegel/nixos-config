{ ... }:

{
  services.avahi = {
    enable = true;
    nssmdns = true;
    ipv6 = true;
  };
}
