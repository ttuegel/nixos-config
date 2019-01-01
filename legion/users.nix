{ config, lib, pkgs, ... }:

let
  readHashedPassword = file:
    lib.fileContents file;
in

{

  users.users = {
    etuegel = {
      uid = 1100;
      description = "Erin Tuegel";
      home = "/home/etuegel";
      createHome = true;
      group = "users";
      extraGroups = [ ];
      hashedPassword = readHashedPassword ./etuegel.hashedPassword;
    };
  };
}
