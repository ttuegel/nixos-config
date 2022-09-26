{ config, lib, pkgs, ... }:

let
  readHashedPassword = lib.fileContents;
in

{
  users.mutableUsers = false;

  users.users = {
    ttuegel = {
      uid = 1000;
      isNormalUser = true;
      description = "Thomas Tuegel";
      home = "/home/ttuegel";
      createHome = true;
      group = "users";
      extraGroups = [ "adbusers" "lp" "lxd" "vboxusers" "wheel" ];
      hashedPassword = readHashedPassword ./secrets/users/ttuegel/hashed-password;
      shell = "/run/current-system/sw/bin/fish";
      openssh.authorizedKeys.keyFiles = [ ./secrets/ttuegel.pub ];
    };
    root.hashedPassword = readHashedPassword ./secrets/users/root/hashed-password;
  };

  security.pam.loginLimits = [
    {
      domain = "*";
      type = "soft";
      item = "nofile";
      value = "4096";
    }
  ];

}
