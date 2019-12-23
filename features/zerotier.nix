{ ... }:

let
  privateZeroTierInterfaces = [ "zt44xijrje" ];
in

{
  # No firewall on the ZeroTier interfaces.
  networking.firewall.trustedInterfaces = privateZeroTierInterfaces;

  # Advertise mDNS over ZeroTier only.
  services.avahi.interfaces = privateZeroTierInterfaces;

  services.zerotierone = {
    enable = true;
    joinNetworks = [ "af415e486fda8d4b" ];
  };
}
