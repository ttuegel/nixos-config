{ lib, pkgs, ... }:

{
  systemd.services.fstrim = {
    startAt = "Mon 04:00:00";
    serviceConfig = {
      ExecStart = "${lib.getBin pkgs.utillinux}/bin/fstrim -a";
    };
  };
}
