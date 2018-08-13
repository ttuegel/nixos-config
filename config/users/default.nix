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
      shell = lib.mkDefault "/var/run/current-system/sw/bin/fish";
      group = "users";
      extraGroups = [ "adbusers" "lp" "vboxusers" "wheel" ];
      hashedPassword = readHashedPassword ./ttuegel.hashedPassword;
    };
    root.hashedPassword = readHashedPassword ./root.hashedPassword;
  };
}
