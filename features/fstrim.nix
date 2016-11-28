{ lib, pkgs, ... }:

{
  systemd.services.fstrim = {
    after = [ "basic.target" ];
    wantedBy = [ "multi-user.target" ];
    startAt = "Mon 04:00:00";
    serviceConfig = {
      ExecStart = "${lib.getBin pkgs.utillinux}/fstrim -a";
    };
  };
}
