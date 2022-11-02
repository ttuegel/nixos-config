{ config, lib, pkgs, secrets, ... }:

{
  environment.systemPackages = with pkgs; [ wireguard-tools ];

  networking.firewall.allowedUDPPorts = [ 51820 ];

  age.secrets.wireguard-private-key.file = "${secrets}/hosts/olympus/wireguard-private.key";

  networking.wireguard = {
    enable = true;
    interfaces.wg0 = {
      ips = [ "10.100.0.1/24" ];
      listenPort = 51820;
      privateKeyFile = config.age.secrets.wireguard-private-key.path;
      peers = [
        {
          publicKey = "6zcsNzwJiqX27DRTC+yJvxyEIUs+gu94ynw2SxW5N30=";
          allowedIPs = [ "10.100.0.2/32" ];
        }
      ];
    };
  };
}
