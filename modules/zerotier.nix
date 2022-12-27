{ lib, ... }:

let
  privateZeroTierInterfaces = [ "zt44xijrje" ];
in

{
  # ZeroTier is unfree.
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "zerotierone" ];

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
  networking.hosts =
    let
      hosts = {
        maia    = ["10.147.20.29"  "fdaf:415e:486f:da8d:4b99:9387:e1be:deb3"];
        hermes  = ["10.147.20.102" "fdaf:415e:486f:da8d:4b99:93d9:a407:676c"];
        pollux  = ["10.147.20.25"  "fdaf:415e:486f:da8d:4b99:93e9:0fc5:a780"];
        zeus    = ["10.147.20.191" "fdaf:415e:486f:da8d:4b99:93ad:ab2c:ef1a"];
        olympus = ["10.147.20.33"  "fdaf:415e:486f:da8d:4b99:93f2:c6fb:3e54"];
      };
      hostLine = host: addr: { "${addr}" = [ host "${host}.local" ]; };
      hostLines = host: addrs: concatAttrs (builtins.map (hostLine host) addrs);
      concatAttrs1 = attr1: attr2: attr1 // attr2;
      concatAttrs = builtins.foldl' concatAttrs1 {};
    in
      concatAttrs (lib.mapAttrsToList hostLines hosts);

}
