{ config, lib, pkgs, ... }:

{

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql94;
  };

  services.quassel = {
    enable = true;
    interfaces = [ "0.0.0.0" ];
  };
  systemd.services.quassel.after = [ "postgresql.service" ];

  environment.systemPackages = with pkgs; [
    openssl
  ];

}
