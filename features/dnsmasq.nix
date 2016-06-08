{ ... }:

{
  networking = {
    extraHosts = ''
      192.168.0.2 tuegel.mooo.com
    '';
    firewall = {
      enable = false;
      allowPing = true;
      allowedTCPPorts = [ 631 5000 8080 ];
    };
  };

  services.dnsmasq = {
    enable = true;
    extraConfig = ''
      interface=enp2s0
      dhcp-range=192.168.1.2,192.168.1.127
      dhcp-host=DEV1B82FE,192.168.1.2
    '';
    resolveLocalQueries = false;
  };
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = true;
  };
}
