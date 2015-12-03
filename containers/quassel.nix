{ config, lib, pkgs, ... }:

{

  imports = [ ./passwords.nix ];

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql94;
  };

  services.quassel = {
    enable = true;
    interfaces = [ "0.0.0.0" ];
  };
  systemd.services.quassel.after = [ "postgresql.service" ];

  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    openssl
  ];

  users.mutableUsers = false;

}
