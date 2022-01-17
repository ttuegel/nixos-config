{ config, lib, pkgs, ... }:

{
  users.users.laminar = {
    group = "laminar";
    isSystemUser = true;
    home = "/var/lib/laminar";
  };
  users.groups.laminar = {};

  environment.systemPackages = [ pkgs.laminar ];

  systemd.services.laminar = {
    enable = true;
    description = "Laminar continuous integration service";
    documentation = [
      "man:laminard(8)"
      "https://laminar.ohwg.net/docs.html"
    ];
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      User = "laminar";
      ExecStart = "${lib.getBin pkgs.laminar}/bin/laminard";
      Environment = [
        "LAMINAR_HOME=/var/lib/laminar"
        # "LAMINAR_BIND_HTTP=*:8080"
        # "LAMINAR_BIND_RPC=unix-abstract:laminar"
        # "LAMINAR_TITLE="
        # "LAMINAR_KEEP_RUNDIRS=0"
        # "LAMINAR_BASE_URL=/"
        # "LAMINAR_ARCHIVE_URL="
      ];
    };
  };
}
