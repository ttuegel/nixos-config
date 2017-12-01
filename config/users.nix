{ config, lib, pkgs, ... }:

{
  imports = [
    ./passwords.nix
  ];

  users.mutableUsers = false;

  users.extraUsers = {
    ttuegel = {
      uid = 1000;
      description = "Thomas Tuegel";
      home = "/home/ttuegel";
      createHome = true;
      shell = lib.mkDefault "/var/run/current-system/sw/bin/fish";
      group = "users";
      extraGroups = [ "adbusers" "lp" "vboxusers" "wheel" ];
    };
  };
}
