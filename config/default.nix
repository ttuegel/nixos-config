{ config, pkgs, ... }:

{
  imports = [
    ./nixpkgs
    ./terminfo.nix
    ./udev.nix
    ./users
  ];

  i18n = {
    defaultLocale = "en_US.utf8";
  };

  services.avahi.enable = true;
  services.avahi.nssmdns = true;

  services.ntp.enable = false;
  services.chrony.enable = true;

  services.nscd.config = ''
    # We basically use nscd as a proxy for forwarding nss requests to appropriate
    # nss modules, as we run nscd with LD_LIBRARY_PATH set to the directory
    # containing all such modules
    # Note that we can not use `enable-cache no` As this will actually cause nscd
    # to just reject the nss requests it receives, which then causes glibc to
    # fallback to trying to handle the request by itself. Which won't work as glibc
    # is not aware of the path in which the nss modules live.  As a workaround, we
    # have `enable-cache yes` with an explicit ttl of 0
    server-user             nscd

    enable-cache            passwd          yes
    positive-time-to-live   passwd          0
    negative-time-to-live   passwd          0
    shared                  passwd          yes

    enable-cache            group           yes
    positive-time-to-live   group           0
    negative-time-to-live   group           0
    shared                  group           yes

    enable-cache            netgroup        yes
    positive-time-to-live   netgroup        0
    negative-time-to-live   netgroup        0
    shared                  netgroup        yes

    enable-cache            hosts           yes
    positive-time-to-live   hosts           0
    negative-time-to-live   hosts           0
    shared                  hosts           yes

    enable-cache            services        yes
    positive-time-to-live   services        0
    negative-time-to-live   services        0
    shared                  services        yes
  '';
}
