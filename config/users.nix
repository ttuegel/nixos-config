{ config, pkgs, ... }:

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
      shell = "/var/run/current-system/sw/bin/zsh";
      group = "users";
      extraGroups = [ "lp" "vboxusers" "wheel" ];
    };
  };
}
