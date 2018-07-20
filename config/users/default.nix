{ config, lib, pkgs, ... }:

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
      hashedPassword = builtins.readFile ./ttuegel.hashedPassword;
    };
    root.hashedPassword = builtins.readFile ./root.hashedPassword;
  };
}
