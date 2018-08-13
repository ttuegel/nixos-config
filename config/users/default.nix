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
      hashedPassword = lib.removeSuffix "\n" (builtins.readFile ./ttuegel.hashedPassword);
    };
    root.hashedPassword = lib.removeSuffix "\n" (builtins.readFile ./root.hashedPassword);
  };
}
