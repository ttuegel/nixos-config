{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ wireguard ];
  networking.firewall.allowedUDPPorts = [ 51820 ];
  networking.wireguard = {
    enable = true;
    interfaces.wg0 = {
      ips = [ "10.100.0.1/24" ];
      listenPort = 51820;
      privateKeyFile = "/var/lib/wireguard/private.key";
      peers = [
        {
          publicKey = "6zcsNzwJiqX27DRTC+yJvxyEIUs+gu94ynw2SxW5N30=";
          allowedIPs = [ "10.100.0.2/32" ];
        }
      ];
    };
  };
}
