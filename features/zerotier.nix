{ ... }:

let
  privateZeroTierInterfaces = [ "zt44xijrje" ];
in

{
  # No firewall on the ZeroTier interfaces.
  networking.firewall.trustedInterfaces = privateZeroTierInterfaces;

  # Advertise mDNS over ZeroTier only.
  services.avahi.interfaces = privateZeroTierInterfaces;

  # Join my private ZeroTier network.
  services.zerotierone = {
    enable = true;
    joinNetworks = [ "af415e486fda8d4b" ];
  };

  # Map ZeroTier addresses to hostnames.
  networking.hosts = {
    "10.147.20.25"  = [ "pollux"   "pollux.local"   ];
    "10.147.20.98"  = [ "dioscuri" "dioscuri.local" ];
    "10.147.20.131" = [ "demeter"  "demeter.local"  ];
    "10.147.20.191" = [ "zeus"     "zeus.local"     ];
  };

}
