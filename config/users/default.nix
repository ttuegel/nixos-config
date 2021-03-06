{ config, lib, pkgs, ... }:

let
  readHashedPassword = lib.fileContents;
in

{
  users.mutableUsers = false;

  users.users = {
    ttuegel = {
      uid = 1000;
      description = "Thomas Tuegel";
      home = "/home/ttuegel";
      createHome = true;
      group = "users";
      extraGroups = [ "adbusers" "lp" "lxd" "vboxusers" "wheel" ];
      hashedPassword = readHashedPassword ../../secrets/users/ttuegel/hashed-password;
      shell = "/run/current-system/sw/bin/fish";
    };
    root.hashedPassword = readHashedPassword ../../secrets/users/root/hashed-password;
  };
}
