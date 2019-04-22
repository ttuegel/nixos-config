{ config, lib, pkgs, ... }:

let
  readHashedPassword = file:
    lib.fileContents file;
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
      hashedPassword = readHashedPassword ./ttuegel.hashedPassword;
      shell = "/run/current-system/sw/bin/fish";
    };
    root.hashedPassword = readHashedPassword ./root.hashedPassword;
  };
}
